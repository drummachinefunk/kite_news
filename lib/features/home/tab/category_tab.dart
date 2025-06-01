import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel_bloc.dart';
import 'package:kagi_news/features/home/tab/category_item.dart';
import 'package:kagi_news/features/home/tab/category_tab_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  void _pushCarousel(BuildContext context, List<Cluster> clusters, int index) {
    // showModalBottomSheet(
    //   context: context,
    //   scrollControlDisabledMaxHeightRatio: 0.88,
    //   builder: (context) {
    //     return BlocProvider(
    //       create:
    //           (context) =>
    //               ClusterCarouselBloc(clusters: clusters, index: index)
    //                 ..add(const ClusterCarouselStarted()),
    //       child: const ClusterCarousel(),
    //     );
    //   },
    // );
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        builder:
            (context) => BlocProvider(
              create:
                  (context) =>
                      ClusterCarouselBloc(clusters: clusters, index: index)
                        ..add(const ClusterCarouselStarted()),
              child: const ClusterCarousel(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTabBloc, CategoryTabState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ListView.separated(
              itemBuilder:
                  (context, index) => CategoryItem(
                    cluster: state.clusters[index],
                    onTap: () => _pushCarousel(context, state.clusters, index),
                  ),
              separatorBuilder:
                  (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemCount: state.clusters.length,
            ),
          ),
        );
      },
    );
  }
}
