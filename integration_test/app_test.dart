import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kagi_news/features/domain_articles/domain_articles_dialog.dart';
import 'package:kagi_news/features/home/home_page.dart';
import 'package:kagi_news/features/settings/settings_page.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_pager/story_pager.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/main.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../test/mocks/mock_data.dart';
import '../test/mocks/mock_news_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App navigation tests', () {
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

    testWidgets('Tapping the tab bar changes to the category selected', (
      WidgetTester tester,
    ) async {
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

      // Should see World category articles
      expect(find.text(mockWorldCategoryResponse.clusters.first.title), findsWidgets);
      // Should not see Tech category articles
      expect(find.text(mockTechCategoryResponse.clusters.first.title), findsNothing);
    });

    testWidgets('Pressing settings button opens settings', (WidgetTester tester) async {
      await tester.pumpWidget(const KiteApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('Tapping an article opens the article reader', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(const KiteApp());
        await tester.pumpAndSettle();

        // Verify home page is displayed
        expect(find.byType(HomePage), findsOneWidget);

        // Tap on the first article in the Tech category
        await tester.tap(find.text(mockTechCategoryResponse.clusters.first.title));
        await tester.pumpAndSettle();

        // // Verify the article reader is displayed
        expect(find.byType(StoryPager), findsOneWidget);
      });
    });

    testWidgets('Tapping the close button closes the article reader', (WidgetTester tester) async {
      await mockNetworkImages(() async {
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
    });

    testWidgets('Tapping a source presents the domain articles dialog', (
      WidgetTester tester,
    ) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(const KiteApp());
        await tester.pumpAndSettle();

        final cluster = mockTechCategoryResponse.clusters.first;

        // Tap on the first article in the Tech category
        await tester.tap(find.text(cluster.title));
        await tester.pumpAndSettle();

        // Verify the article reader is displayed
        expect(find.byType(StoryPager), findsOneWidget);

        // Scroll to the sources section
        final sourcesFinder = find.byType(Sources);
        while (tester.any(sourcesFinder) == false) {
          await tester.fling(find.byType(CustomScrollView), const Offset(0, -500), 1000);
          await tester.pumpAndSettle();
        }

        // // Verify sources are displayed
        expect(find.byType(Sources), findsOneWidget);
        expect(find.text(cluster.domains.first.name), findsOneWidget);

        await tester.tap(
          find.descendant(
            of: find.byType(Sources),
            matching: find.text(cluster.domains.first.name),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(DomainArticlesDialog), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(DomainArticlesDialog),
            matching: find.text(cluster.domains.first.name),
          ),
          findsOneWidget,
        );
      });
    });

    testWidgets('Tapping the close button closes the article reader', (WidgetTester tester) async {
      await mockNetworkImages(() async {
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
    });

    testWidgets('Swiping down on the article reader closes it', (WidgetTester tester) async {
      await mockNetworkImages(() async {
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
    });

    testWidgets('Swiping left on the article reader goes to the next story', (
      WidgetTester tester,
    ) async {
      await mockNetworkImages(() async {
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
    });
  });
}
