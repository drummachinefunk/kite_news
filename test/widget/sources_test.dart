import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_details/models/source_item.dart';
import 'package:kagi_news/localization/app_localizations.dart';
import 'package:kagi_news/locator.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mocks/mock_cache_manager.dart';
import '../mocks/mock_data.dart';

void main() {

  setUp(() {
    locator.registerSingleton<BaseCacheManager>(MockCacheManager());
  });

  tearDown(() {
    locator.reset();
  });
  
  testWidgets('Sources widget displays source names without more button', (
    WidgetTester tester,
  ) async {
    final items = [source1WithTwoArticles, source2WithTwoArticles];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CustomScrollView(slivers: [Sources(sources: items, onSourceSelected: (source) {})]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(items[0].name), findsWidgets);
    expect(find.text(items[1].name), findsWidgets);
    expect(find.byKey(const ValueKey('show_more_button')), findsNothing);
  });

  testWidgets('Sources widget displays source names with more button', (WidgetTester tester) async {
    final items = [
      source1WithTwoArticles,
      source2WithTwoArticles,
      source1WithTwoArticles,
      source2WithTwoArticles,
      source1WithTwoArticles,
      source2WithTwoArticles,
    ];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CustomScrollView(slivers: [Sources(sources: items, onSourceSelected: (source) {})]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(items[0].name), findsWidgets);
    expect(find.text(items[1].name), findsWidgets);
    expect(find.byKey(const ValueKey('show_more_button')), findsOneWidget);
  });

  testWidgets('Sources shows all items and show less button when expanded', (
    WidgetTester tester,
  ) async {
    final items = [
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
      source1WithTwoArticles,
    ];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CustomScrollView(
            slivers: [Sources(sources: items, expanded: true, onSourceSelected: (source) {})],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(items[0].name), findsExactly(items.length));
    expect(find.byKey(const ValueKey('show_more_button')), findsOneWidget);
  });

  testWidgets('Tapping a source initiates a callback', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      final items = [source1WithTwoArticles, source2WithTwoArticles];

      SourceItem? sourceTapped;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                Sources(
                  sources: items,
                  onSourceSelected: (source) {
                    sourceTapped = source;
                  },
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(items.first.name));
      await tester.pumpAndSettle();

      expect(sourceTapped, items.first);
    });
  });

  testWidgets('Pressing the more button expands the list', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      final items = [
        source1WithTwoArticles,
        source2WithTwoArticles,
        source1WithTwoArticles,
        source2WithTwoArticles,
        source1WithTwoArticles,
        source2WithTwoArticles,
      ];

      var moreTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                Sources(
                  sources: items,
                  onSourceSelected: (source) {},
                  onToggleExpanded: () {
                    moreTapped = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('show_more_button')));
      await tester.pumpAndSettle();

      expect(moreTapped, isTrue);
    });
  });
}
