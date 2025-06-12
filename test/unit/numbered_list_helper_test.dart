import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_details/utilities/numbered_list_helpers.dart';

void main() {
  test('Items with :: separators', () {
    final items = [
      '1 :: First item',
      '2 :: Second item with more text',
      '3 :: Third item',
      '4 :: Fourth item with extra details',
    ];
    final result = NumberedListHelper.itemsFromList(items);
    expect(result.length, 4);
    expect(result[0].title, '1');
    expect(result[0].text, 'First item');
    expect(result[1].title, '2');
    expect(result[1].text, 'Second item with more text');
    expect(result[2].title, '3');
    expect(result[2].text, 'Third item');
    expect(result[3].title, '4');
    expect(result[3].text, 'Fourth item with extra details');
  });

  test('Items with : separators', () {
    final items = [
      '1 : First item',
      '2 : Second item with more text',
      '3 : Third item',
      '4 : Fourth item with extra details',
    ];
    final result = NumberedListHelper.itemsFromList(items, separator: ':');
    expect(result.length, 4);
    expect(result[0].title, '1');
    expect(result[0].text, 'First item');
    expect(result[1].title, '2');
    expect(result[1].text, 'Second item with more text');
    expect(result[2].title, '3');
    expect(result[2].text, 'Third item');
    expect(result[3].title, '4');
    expect(result[3].text, 'Fourth item with extra details');
  });
}
