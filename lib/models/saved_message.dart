class SavedMessage {
  final String app;
  final String sender;
  final String text;
  final int time;
  final DateTime receivedAt;
  bool isDeleted;

  SavedMessage({
    required this.app,
    required this.sender,
    required this.text,
    required this.time,
    required this.receivedAt,
    this.isDeleted = false,
  });

  // Har message ka apna nishan: app + waqt + text
  String get key => '$app|$time|$text';

  Map<String, Object?> toMap() => {
        'app': app,
        'sender': sender,
        'text': text,
        'time': time,
        'received_at': receivedAt.millisecondsSinceEpoch,
        'is_deleted': isDeleted ? 1 : 0,
      };

  factory SavedMessage.fromMap(Map<String, Object?> map) => SavedMessage(
        app: map['app'] as String? ?? 'WhatsApp',
        sender: map['sender'] as String,
        text: map['text'] as String,
        time: map['time'] as int,
        receivedAt:
            DateTime.fromMillisecondsSinceEpoch(map['received_at'] as int),
        isDeleted: (map['is_deleted'] as int) == 1,
      );
}