import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/custom_scroll_physics.dart';
import 'package:kagi_news/navigation/navigation.dart';
import 'package:kagi_news/features/story_details/components/location.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_details/components/text_section.dart';
import 'package:kagi_news/localization/localization.dart';

import 'components/article_box.dart';
import 'components/bullet_list.dart';
import 'components/carousel_list.dart';
import 'components/numbered_list.dart';
import 'story_details_bloc.dart';
import 'components/quote_box.dart';
import 'components/sliver_with_padding.dart';
import 'components/sliver_spacing.dart';
import 'utilities/numbered_list_helpers.dart';

class StoryDetailsPage extends StatefulWidget {
  const StoryDetailsPage({super.key});

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  bool _sourcesExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryDetailsBloc, StoryDetailsState>(
      builder: (context, state) {
        final article1 = state.cluster.articles.isNotEmpty ? state.cluster.articles.first : null;
        final article2 = state.cluster.articles.length > 1 ? state.cluster.articles[1] : null;

        return CustomScrollView(
          physics: const CustomScrollPhysics(),
          slivers: [
            SliverWithPadding(
              child: Text(state.cluster.category, style: Theme.of(context).textTheme.titleSmall),
            ),
            SliverSpacing(height: 3),
            SliverWithPadding(
              child: Text(state.cluster.title, style: Theme.of(context).textTheme.displaySmall),
            ),
            SliverSpacing(),
            SliverWithPadding(
              child: Text(
                state.cluster.shortSummary,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SliverSpacing(),
            if (state.cluster.location.isNotEmpty) ...[
              SliverWithPadding(child: Location(state.cluster.location)),
              SliverSpacing(),
            ],
            if (article1 != null) ...[
              SliverToBoxAdapter(
                child: ArticleBox(
                  imageUrl: article1.image,
                  caption: article1.imageCaption,
                  source: article1.domain,
                  url: article1.link,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.talkingPoints.isNotEmpty) ...[
              SliverWithPadding(
                child: NumberedList(
                  title: L.of(context).highlights,
                  items: NumberedListHelper.itemsFromList(
                    state.cluster.talkingPoints,
                    separator: ':',
                  ),
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.quote.isNotEmpty) ...[
              SliverWithPadding(
                child: QuoteBox(
                  title: null,
                  text: state.cluster.quote,
                  author: state.cluster.qouteAuthor,
                  source: state.cluster.quoteSourceUrl,
                ),
              ),
              SliverSpacing(),
            ],
            if (article2 != null) ...[
              SliverToBoxAdapter(
                child: ArticleBox(
                  imageUrl: article2.image,
                  caption: article2.imageCaption,
                  source: article2.domain,
                  url: article2.link,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.perspectives.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: CarouselList(
                  title: L.of(context).perspectives,
                  items:
                      state.cluster.perspectives
                          .map(
                            (e) => CarouselListItemData(
                              text: e.text,
                              source: e.sources.first.name,
                              url: e.sources.first.url,
                            ),
                          )
                          .toList(),
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.historicalBackground.isNotEmpty) ...[
              SliverWithPadding(
                child: TextSection(
                  title: L.of(context).historicalBackground,
                  text: state.cluster.historicalBackground,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.humanitarianImpact.isNotEmpty) ...[
              SliverWithPadding(
                child: TextSection(
                  title: L.of(context).humanitarianImpact,
                  text: state.cluster.humanitarianImpact,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.timeline.isNotEmpty) ...[
              SliverWithPadding(
                child: NumberedList(
                  title: L.of(context).timelineOfEvents,
                  items: NumberedListHelper.itemsFromList(state.cluster.timeline),
                ),
              ),
              SliverSpacing(),
            ],

            if (state.cluster.destinationHighlights.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: L.of(context).destinationHighlights,
                  items: state.cluster.destinationHighlights,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.gameplayMechanics.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: L.of(context).gameplayMechanics,
                  items: state.cluster.gameplayMechanics,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.industryImpact.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: L.of(context).industryImpact,
                  items: state.cluster.industryImpact,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.technicalDetails.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: L.of(context).technicalDetails,
                  items: state.cluster.technicalDetails,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.userActionItems.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: L.of(context).userActionItems,
                  items: state.cluster.userActionItems,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.sources.isNotEmpty) ...[
              SliverWithPadding(
                child: Text(L.of(context).sources, style: Theme.of(context).textTheme.titleMedium),
              ),
              Sources(
                sources: state.sources,
                expanded: _sourcesExpanded,
                onToggleExpanded: () => setState(() => _sourcesExpanded = !_sourcesExpanded),
                onSourceSelected: (source) => presentDomainArticles(context, source),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.didYouKnow.isNotEmpty) ...[
              SliverWithPadding(
                child: QuoteBox(title: L.of(context).didYouKnow, text: state.cluster.didYouKnow),
              ),
              SliverSpacing(),
            ],
            SliverSpacing(height: 100),
          ],
        );
      },
    );
  }
}
