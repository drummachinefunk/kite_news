import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/domain_articles/domain_articles_dialog.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_pager/story_pager.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/main.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mocks/mock_data.dart';
import '../mocks/mock_news_repository.dart';

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

  testWidgets('Tapping a source presents the domain articles dialog', (WidgetTester tester) async {
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
        find.descendant(of: find.byType(Sources), matching: find.text(cluster.domains.first.name)),
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
}
