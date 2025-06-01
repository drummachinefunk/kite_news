import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/carousel.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel_bloc.dart';
import 'package:kagi_news/features/cluster_details/cluster_details_bloc.dart';
import 'package:kagi_news/features/cluster_details/cluster_details_page.dart';

class ClusterCarousel extends StatelessWidget {
  const ClusterCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClusterCarouselBloc, ClusterCarouselState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text('${state.selectedIndex + 1} / ${state.clusters.length}'),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Carousel(
                    itemBuilder: (context, index) {
                      return BlocProvider(
                        create:
                            (context) =>
                                ClusterDetailsBloc(cluster: state.clusters[index])
                                  ..add(const ClusterDetailsStarted()),
                        child: const ClusterDetailsPage(),
                      );
                    },
                    length: state.clusters.length,
                    index: state.selectedIndex,
                    onIndexChanged: (int index) {
                      context.read<ClusterCarouselBloc>().add(ClusterCarouselIndexChanged(index));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
