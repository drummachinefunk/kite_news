// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/main.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    locator.registerSingleton<NewsRepository>(mockNewsRepository);
  });

  tearDown(() {
    locator.reset();
  });

  testWidgets('Your test here', (WidgetTester tester) async {
    when(() => mockNewsRepository.loadCategories()).thenAnswer((_) async => mockCategories);
    when(
      () => mockNewsRepository.loadCategory(mockTechCategory),
    ).thenAnswer((_) async => mockTechCategoryResponse);

    await tester.pumpWidget(const KiteApp());

    // Assert: verify behavior
  });
}
