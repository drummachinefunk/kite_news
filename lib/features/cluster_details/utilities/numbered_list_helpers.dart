import 'package:kagi_news/features/cluster_details/components/numbered_list.dart';

class NumberedListHelpers {
  static List<NumberedListItemData> itemsFromList(List<String> items, {String separator = '::'}) {
    return items.map((e) {
      final parts = e.split(separator);
      if (parts.length >= 2) {
        return NumberedListItemData(
          title: parts.first.trim(),
          text: parts.length > 1 ? parts.sublist(1).join(separator).trim() : '',
        );
      }
      return NumberedListItemData(title: parts.first, text: '');
    }).toList();
  }
}
