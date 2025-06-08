import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel.dart';
import 'package:kagi_news/features/home/home_page.dart';
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

  testWidgets('Tapping the tab bar changes to the category selected', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();
    expect(find.text(mockTechCategoryResponse.clusters.first.title), findsWidgets);

    // Verify we don't see world category articles initially
    expect(find.text(mockWorldCategoryResponse.clusters.first.title), findsNothing);
    await tester.tap(find.text(mockWorldCategory.name));
    await tester.pumpAndSettle();
    // Verify we see world category articles after tapping
    expect(find.text(mockWorldCategoryResponse.clusters.first.title), findsWidgets);

    // Verify we don't see USA category articles initially
    expect(find.text(mockUsaCategoryResponse.clusters.first.title), findsNothing);
    await tester.tap(find.text(mockUsaCategory.name));
    await tester.pumpAndSettle();
    // Verify we see USA category articles after tapping
    expect(find.text(mockUsaCategoryResponse.clusters.first.title), findsWidgets);
  });

  testWidgets('Swiping left changes to the next category', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Start on the first category (Tech)
    expect(find.text(mockTechCategoryResponse.clusters.first.title), findsWidgets);

    // Swipe left to World category
    await tester.drag(find.byType(TabBarView), const Offset(-500, 0));
    await tester.pumpAndSettle();

    // // Should see World category articles
    expect(find.text(mockWorldCategoryResponse.clusters.first.title), findsWidgets);
    // // Should not see Tech category articles
    expect(find.text(mockTechCategoryResponse.clusters.first.title), findsNothing);
  });

  testWidgets('Tapping an article opens the article reader', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Verify home page is displayed
    expect(find.byType(HomePage), findsOneWidget);

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(ClusterCarousel), findsOneWidget);
  });

  testWidgets('Tapping the close button closes the article reader', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(ClusterCarousel), findsOneWidget);

    // Dismiss the article reader
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Verify we are back to the main screen
    expect(find.byType(ClusterCarousel), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Swiping down on the article reader closes it', (WidgetTester tester) async {
    await tester.pumpWidget(const KiteApp());
    await tester.pumpAndSettle();

    // Tap on the first article in the Tech category
    await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
    await tester.pumpAndSettle();

    // Verify the article reader is displayed
    expect(find.byType(ClusterCarousel), findsOneWidget);

    // Swipe down to close the article reader
    await tester.fling(find.byType(CustomScrollView), const Offset(0, 500), 1000);
    await tester.pumpAndSettle();

    // Verify we are back to the main screen
    expect(find.byType(ClusterCarousel), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
