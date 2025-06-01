import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/cluster_details/components/article_box.dart';
import 'package:kagi_news/features/cluster_details/components/bullet_list.dart';
import 'package:kagi_news/features/cluster_details/components/carousel_list.dart';
import 'package:kagi_news/features/cluster_details/components/numbered_list.dart';
import 'package:kagi_news/features/cluster_details/cluster_details_bloc.dart';
import 'package:kagi_news/features/cluster_details/components/quote_box.dart';
import 'package:kagi_news/features/cluster_details/components/sliver_with_padding.dart';
import 'package:kagi_news/features/cluster_details/components/sliver_spacing.dart';
import 'package:kagi_news/features/cluster_details/utilities/numbered_list_helpers.dart';

class ClusterDetailsPage extends StatefulWidget {
  const ClusterDetailsPage({super.key, required this.edgeDragged});

  final VoidCallback edgeDragged;

  @override
  State<ClusterDetailsPage> createState() => _ClusterDetailsPageState();
}

class _ClusterDetailsPageState extends State<ClusterDetailsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollChanged);
    super.initState();
  }

  void _scrollChanged() {
    //debugPrint('Scroll position: ${_scrollController.position.pixels}');
    if (_scrollController.position.pixels < 0) {
      widget.edgeDragged(); // Notify the parent that the top edge was reached
    }
    // final isTop = _scrollController.position.pixels == 0;
    // if (isTop) {
    //   widget.edgeDragged(); // Notify the parent that the top edge was reached
    // }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClusterDetailsBloc, ClusterDetailsState>(
      builder: (context, state) {
        final article1 = state.cluster.articles.isNotEmpty ? state.cluster.articles.first : null;
        final article2 = state.cluster.articles.length > 1 ? state.cluster.articles[1] : null;

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverSpacing(),
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
                      items: NumberedListHelpers.itemsFromList(
                        state.cluster.talkingPoints,
                        separator: ':',
                      ),
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
                if (state.cluster.timeline.isNotEmpty) ...[
                  SliverWithPadding(
                    child: NumberedList(
                      title: 'Timeline',
                      items: NumberedListHelpers.itemsFromList(state.cluster.timeline),
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
                    child: BulletList(
                      title: 'Industry Impact',
                      items: state.cluster.industryImpact,
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
                    child: BulletList(
                      title: 'User Action Items',
                      items: state.cluster.userActionItems,
                    ),
                  ),
                  SliverSpacing(),
                ],
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
            ),
          ),
        );
      },
    );
  }
}
