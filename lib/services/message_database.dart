import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/saved_message.dart';

class MessageDatabase {
  MessageDatabase._();
  static final MessageDatabase instance = MessageDatabase._();

  Future<Database>? _dbFuture;

  Future<Database> get _database => _dbFuture ??= _open();

  Future<Database> _open() async {
    final String dir = await getDatabasesPath();
    final String path = join(dir, 'messages.db');
    return openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            app TEXT NOT NULL DEFAULT 'WhatsApp',
            sender TEXT NOT NULL,
            text TEXT NOT NULL,
            time INTEGER NOT NULL,
            received_at INTEGER NOT NULL,
            is_deleted INTEGER NOT NULL DEFAULT 0,
            UNIQUE(app, sender, time, text)
          )
        ''');
        await _createDeletedKeys(db);
        await _createKnownState(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE messages ADD COLUMN app TEXT NOT NULL DEFAULT 'WhatsApp'",
          );
        }
        if (oldVersion < 3) {
          await _createDeletedKeys(db);
        }
        if (oldVersion < 4) {
          await _createKnownState(db);
        }
      },
    );
  }

  // Jo messages user ne app se delete kiye, unka sirf "nishan" (hash) yahan rehta hai
  Future<void> _createDeletedKeys(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS deleted_keys (
        app TEXT NOT NULL,
        sender TEXT NOT NULL,
        time INTEGER NOT NULL,
        text_hash INTEGER NOT NULL,
        PRIMARY KEY (app, sender, time, text_hash)
      )
    ''');
  }

  // Har chat ki aakhri notification mein kaunse messages the ("time|text" ki list, JSON).
  // Ye UI aur headless dono isolates ke liye ek hi sachchi jagah hai.
  Future<void> _createKnownState(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS known_state (
        app TEXT NOT NULL,
        sender TEXT NOT NULL,
        items_json TEXT NOT NULL,
        PRIMARY KEY (app, sender)
      )
    ''');
  }

  // Text ka chhota pakka nishan (FNV-1a). Har dafa ek jaisa nateeja deta hai.
  int _hash(String text) {
    int h = 0x811C9DC5;
    for (final int c in text.codeUnits) {
      h ^= c;
      h = (h * 0x01000193) & 0xFFFFFFFF;
    }
    return h;
  }

  // ---------------- KNOWN STATE ----------------

  Future<List<String>> getKnownKeys(String app, String sender) async {
    final Database db = await _database;
    final List<Map<String, Object?>> rows = await db.query(
      'known_state',
      columns: ['items_json'],
      where: 'app = ? AND sender = ?',
      whereArgs: [app, sender],
      limit: 1,
    );
    if (rows.isEmpty) return [];
    try {
      final dynamic decoded = jsonDecode(rows.first['items_json'] as String);
      return (decoded as List<dynamic>).map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }

  // Khali list ka matlab "kuch nahi pata", is liye row hata dete hain
  Future<void> setKnownKeys(
    String app,
    String sender,
    List<String> keys,
  ) async {
    if (keys.isEmpty) {
      await clearKnownKeys(app, sender);
      return;
    }
    final Database db = await _database;
    await db.insert('known_state', {
      'app': app,
      'sender': sender,
      'items_json': jsonEncode(keys),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clearKnownKeys(String app, String sender) async {
    final Database db = await _database;
    await db.delete(
      'known_state',
      where: 'app = ? AND sender = ?',
      whereArgs: [app, sender],
    );
  }

  // ---------------- MESSAGES ----------------

  Future<void> insert(SavedMessage m) async {
    final Database db = await _database;
    await db.insert(
      'messages',
      m.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> markDeletedByTime(String app, String sender, int time) async {
    final Database db = await _database;
    await db.update(
      'messages',
      {'is_deleted': 1},
      where: 'app = ? AND sender = ? AND time = ?',
      whereArgs: [app, sender, time],
    );
  }

  Future<void> markDeletedExact(
    String app,
    String sender,
    int time,
    String text,
  ) async {
    final Database db = await _database;
    await db.update(
      'messages',
      {'is_deleted': 1},
      where: 'app = ? AND sender = ? AND time = ? AND text = ?',
      whereArgs: [app, sender, time, text],
    );
  }

  Future<void> markLatestUndeleted(String app, String sender) async {
    final Database db = await _database;
    final List<Map<String, Object?>> rows = await db.query(
      'messages',
      where: 'app = ? AND sender = ? AND is_deleted = 0',
      whereArgs: [app, sender],
      orderBy: 'time DESC',
      limit: 1,
    );
    if (rows.isEmpty) return;
    final int id = rows.first['id'] as int;
    await db.update(
      'messages',
      {'is_deleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Message pehle se save hai, ya user ne usay delete kar diya tha?
  // Dono soorat mein "haan", taake delete kiya hua message wapas save na ho.
  Future<bool> existsKey(
    String app,
    String sender,
    int time,
    String text,
  ) async {
    final Database db = await _database;

    final List<Map<String, Object?>> rows = await db.query(
      'messages',
      where: 'app = ? AND sender = ? AND time = ? AND text = ?',
      whereArgs: [app, sender, time, text],
      limit: 1,
    );
    if (rows.isNotEmpty) return true;

    final List<Map<String, Object?>> removed = await db.query(
      'deleted_keys',
      where: 'app = ? AND sender = ? AND time = ? AND text_hash = ?',
      whereArgs: [app, sender, time, _hash(text)],
      limit: 1,
    );
    return removed.isNotEmpty;
  }

  // User ke chune hue messages hamesha ke liye hata do
  Future<void> deleteMessages(List<SavedMessage> items) async {
    if (items.isEmpty) return;
    final Database db = await _database;

    await db.transaction((txn) async {
      final Batch batch = txn.batch();
      for (final SavedMessage m in items) {
        batch.insert('deleted_keys', {
          'app': m.app,
          'sender': m.sender,
          'time': m.time,
          'text_hash': _hash(m.text),
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
        batch.delete(
          'messages',
          where: 'app = ? AND sender = ? AND time = ? AND text = ?',
          whereArgs: [m.app, m.sender, m.time, m.text],
        );
      }
      await batch.commit(noResult: true);
    });
  }

  // Saare messages hata do. Har message ka sirf gumnaam nishan rakhte hain,
  // taake notification se purane messages dobara save na ho jayein
  Future<void> clearAll() async {
    final Database db = await _database;

    await db.transaction((txn) async {
      final List<Map<String, Object?>> rows = await txn.query(
        'messages',
        columns: ['app', 'sender', 'time', 'text'],
      );

      final Batch batch = txn.batch();
      for (final Map<String, Object?> r in rows) {
        batch.insert('deleted_keys', {
          'app': r['app'],
          'sender': r['sender'],
          'time': r['time'],
          'text_hash': _hash(r['text'] as String),
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }
      batch.delete('messages');
      batch.delete('known_state');
      await batch.commit(noResult: true);
    });
  }

  Future<List<SavedMessage>> getAll() async {
    final Database db = await _database;
    final List<Map<String, Object?>> rows = await db.query(
      'messages',
      orderBy: 'received_at DESC, id DESC',
    );
    return rows.map(SavedMessage.fromMap).toList();
  }
}