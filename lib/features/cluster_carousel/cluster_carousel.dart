import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/animated_translation.dart';
import 'package:kagi_news/components/carousel.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel_bloc.dart';
import 'package:kagi_news/features/cluster_details/cluster_details_bloc.dart';
import 'package:kagi_news/features/cluster_details/cluster_details_page.dart';

class ClusterCarousel extends StatefulWidget {
  const ClusterCarousel({super.key, this.scrollController, required this.onDismiss});

  final ScrollController? scrollController;
  final VoidCallback onDismiss;

  @override
  State<ClusterCarousel> createState() => _ClusterCarouselState();
}

class _ClusterCarouselState extends State<ClusterCarousel> {
  double _dragOffset = 0.0;
  bool _draggin = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClusterCarouselBloc, ClusterCarouselState>(
      builder: (context, state) {
        return AnimatedTranslation(
          offset: Offset(0.0, -_dragOffset),
          duration: _draggin ? Duration.zero : const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('${state.selectedIndex + 1} / ${state.clusters.length}'),
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              onPressed: () => widget.onDismiss(),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.axis != Axis.vertical) {
                          return false; // Only handle vertical overscroll
                        }
                        if (notification is OverscrollNotification && notification.overscroll < 0) {
                          setState(() {
                            _draggin = true;
                            // Apply drag delta to containerOffset
                            _dragOffset += notification.overscroll;
                            // Clamp it if needed
                            _dragOffset = _dragOffset.clamp(-2000.0, 0.0);
                          });
                          return true; // Consume the overscroll
                        }
                        if (notification is ScrollEndNotification) {
                          if (-_dragOffset > MediaQuery.sizeOf(context).height * 0.3) {
                            Navigator.of(context).pop();
                          } else {
                            if (_dragOffset != 0) {
                              _draggin = false;
                              setState(() => _dragOffset = 0.0);
                            }
                          }
                        }
                        return false;
                      },
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
                          context.read<ClusterCarouselBloc>().add(
                            ClusterCarouselIndexChanged(index),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
