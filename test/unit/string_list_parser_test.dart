import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/models/parsing/string_list_parser.dart';

void main() {
  test('String list from empty string', () {
    final result = fromJsonStringList('');
    expect(result, []);
  });

  test('String list from string array', () {
    final result = fromJsonStringList(['One', 'Two', 'Three']);
    expect(result, ['One', 'Two', 'Three']);
  });
}
