class AppCatalogEntry {
  final String name;
  final String imagePath;
  final bool supported;

  const AppCatalogEntry({
    required this.name,
    required this.imagePath,
    required this.supported,
  });
}

const List<AppCatalogEntry> kAppCatalog = [
  AppCatalogEntry(name: 'WhatsApp', imagePath: 'assets/images/apple.png', supported: true),
  AppCatalogEntry(name: 'TikTok', imagePath: 'assets/images/tik-tok.png', supported: true),
  AppCatalogEntry(name: 'Telegram', imagePath: 'assets/images/telegram.png', supported: true),
  AppCatalogEntry(name: 'Instagram', imagePath: 'assets/images/instagram.png', supported: true),
  AppCatalogEntry(name: 'Messenger', imagePath: 'assets/images/messenger.png', supported: true),
  AppCatalogEntry(name: 'Snapchat', imagePath: 'assets/images/snapchat.png', supported: true),
  // Facebook app sirf like/comment jaisi activity bhejti hai, chats Messenger mein hoti hain.
  // Phir bhi test karna ho to isay true kar do.
  AppCatalogEntry(name: 'Facebook', imagePath: 'assets/images/communication.png', supported: true),
  AppCatalogEntry(name: 'X', imagePath: 'assets/images/twitter.png', supported: true),
];

AppCatalogEntry? catalogEntryFor(String name) {
  for (final e in kAppCatalog) {
    if (e.name == name) return e;
  }
  return null;
}