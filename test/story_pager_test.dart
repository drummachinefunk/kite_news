import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_pager/story_pager.dart';
import 'package:kagi_news/features/home/home_page.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/main.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_data.dart';
import 'mocks/mock_news_repository.dart';

void main() {
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    when(() => mockNewsRepository.loadCategories()).thenAnswer((_) async => mockCategories);
    when(
      () => mockNewsRepository.loadCategory(mockTechCategory),
    ).thenAnswer((_) async => mockTechCategoryResponse);
    when(
      () => mockNewsRepository.loadCategory(mockWorldCategory),
    ).thenAnswer((_) async => mockWorldCategoryResponse);
    when(
      () => mockNewsRepository.loadCategory(mockUsaCategory),
    ).thenAnswer((_) async => mockUsaCategoryResponse);
    locator.registerSingleton<NewsRepository>(mockNewsRepository);
  });

  tearDown(() {
    locator.reset();
  });

  testWidgets('Tapping the close button closes the article reader', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(StoryPager), findsOneWidget);

    // Dismiss the article reader
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify we are back to the main screen
    expect(find.byType(StoryPager), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Swiping down on the article reader closes it', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(StoryPager), findsOneWidget);

    // Swipe down to close the article reader
    await tester.fling(find.byType(CustomScrollView), const Offset(0, 500), 1000);
    await tester.pumpAndSettle();

    // Verify we are back to the main screen
    expect(find.byType(StoryPager), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Swiping left on the article reader goes to the next story', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(StoryPager), findsOneWidget);

    await tester.fling(find.byKey(const ValueKey('pager')), const Offset(-200, 0), 1000);
    await tester.pumpAndSettle();

    // Verify the pager is still displayed
    expect(find.byType(StoryPager), findsOneWidget);

    // Verify we see the next story in the pager
    expect(
      find.descendant(
        of: find.byType(StoryPager),
        matching: find.text(mockTechCategoryResponse.clusters[1].title),
      ),
      findsOneWidget,
    );
    // Verify we do not see the first story anymore
    expect(
      find.descendant(
        of: find.byType(StoryPager),
        matching: find.text(mockTechCategoryResponse.clusters[0].title),
      ),
      findsNothing,
    );
  });
}
