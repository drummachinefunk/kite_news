import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/story_details/components/location.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_details/components/text_section.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryDetailsBloc, StoryDetailsState>(
      builder: (context, state) {
        final article1 = state.cluster.articles.isNotEmpty ? state.cluster.articles.first : null;
        final article2 = state.cluster.articles.length > 1 ? state.cluster.articles[1] : null;

        return CustomScrollView(
          physics: const ClampingScrollPhysics(),
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
                  title: 'Highlights',
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
                  title: 'Perspectives',
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
                  title: 'Historical Background',
                  text: state.cluster.historicalBackground,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.humanitarianImpact.isNotEmpty) ...[
              SliverWithPadding(
                child: TextSection(
                  title: 'Humanitarian Impact',
                  text: state.cluster.humanitarianImpact,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.timeline.isNotEmpty) ...[
              SliverWithPadding(
                child: NumberedList(
                  title: 'Timeline of events',
                  items: NumberedListHelper.itemsFromList(state.cluster.timeline),
                ),
              ),
              SliverSpacing(),
            ],

            if (state.cluster.destinationHighlights.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: 'Destination Highlights',
                  items: state.cluster.destinationHighlights,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.destinationHighlights.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: 'Destination Highlights',
                  items: state.cluster.destinationHighlights,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.gameplayMechanics.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: 'Gameplay Mechanics',
                  items: state.cluster.gameplayMechanics,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.industryImpact.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(title: 'Industry Impact', items: state.cluster.industryImpact),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.technicalDetails.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(
                  title: 'Technical Details',
                  items: state.cluster.technicalDetails,
                ),
              ),
              SliverSpacing(),
            ],
            if (state.cluster.userActionItems.isNotEmpty) ...[
              SliverWithPadding(
                child: BulletList(title: 'User Action Items', items: state.cluster.userActionItems),
              ),
              SliverSpacing(),
            ],
            if (state.sources.isNotEmpty) ...[Sources(sources: state.sources), SliverSpacing()],
            if (state.cluster.didYouKnow.isNotEmpty) ...[
              SliverWithPadding(
                child: QuoteBox(title: 'Did You Know', text: state.cluster.didYouKnow),
              ),
              SliverSpacing(),
            ],
            SliverSpacing(),
            SliverSpacing(),
            SliverSpacing(),
          ],
        );
      },
    );
  }
}
