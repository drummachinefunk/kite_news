class ItemData {
  final String title;
  final String text;

  const ItemData({required this.title, required this.text});
}

class ItemDataParser {
  /// Converts a list of strings into a list of [ItemData] based on a specified separator.
  static List<ItemData> itemsFromList(List<String> items, {String separator = '::'}) {
    return items.map((e) {
      final parts = e.split(separator);
      if (parts.length >= 2) {
        return ItemData(
          title: parts.first.trim(),
          text: parts.length > 1 ? parts.sublist(1).join(separator).trim() : '',
        );
      }
      return ItemData(title: '', text: parts.first.trim());
    }).toList();
  }
}
