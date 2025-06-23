import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/animated_translation.dart';
import 'package:kagi_news/components/pager.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/features/story_pager/story_pager_bloc.dart';
import 'package:kagi_news/features/story_details/story_details_bloc.dart';
import 'package:kagi_news/features/story_details/story_details_page.dart';
import 'package:kagi_news/features/story_pager/components/story_pager_toolbar.dart';

class StoryPager extends StatefulWidget {
  const StoryPager({super.key, this.scrollController, required this.onDismiss});

  final ScrollController? scrollController;
  final VoidCallback onDismiss;

  @override
  State<StoryPager> createState() => _StoryPagerState();
}

class _StoryPagerState extends State<StoryPager> {
  double _dragOffset = 0.0;
  bool _draggin = false;
  bool _toolBarVisible = true;
  double _lastScrollPosition = 0.0;

  void _setToolbarVisible(bool visible) {
    if (_toolBarVisible == visible) return;
    setState(() {
      _toolBarVisible = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryPagerBloc, StoryPagerState>(
      builder: (context, state) {
        return AnimatedTranslation(
          offset: Offset(0.0, -_dragOffset),
          duration:
              _draggin ? Duration.zero : const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis != Axis.vertical) {
                    return false; // Only handle vertical scroll notifications
                  }
                  final scrollPosition = notification.metrics.pixels;
                  if (_lastScrollPosition >= scrollPosition) {
                    _setToolbarVisible(true);
                  } else {
                    _setToolbarVisible(false);
                  }
                  _lastScrollPosition = scrollPosition;
                  return true;
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        TitleBar(
                          padding: const EdgeInsets.fromLTRB(16, 3, 10, 3),
                          leading: Text(
                            '${state.selectedIndex + 1} / ${state.clusters.length}',
                          ),
                          title: Text(
                            state.category.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () => widget.onDismiss(),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.axis != Axis.vertical) {
                                return false; // Only handle vertical overscroll
                              }
                              if (notification is OverscrollNotification &&
                                  notification.overscroll < 0) {
                                setState(() {
                                  _draggin = true;
                                  _dragOffset += notification.overscroll;
                                  _dragOffset = _dragOffset.clamp(-5000.0, 0.0);
                                });
                                return true; // Consume the overscroll
                              }
                              if (notification is ScrollEndNotification) {
                                if (-_dragOffset >
                                    MediaQuery.sizeOf(context).height * 0.2) {
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
                            child: Pager(
                              itemBuilder: (context, index) {
                                return BlocProvider(
                                  create:
                                      (context) => StoryDetailsBloc(
                                        cluster: state.clusters[index],
                                      )..add(const StoryDetailsStarted()),
                                  child: const StoryDetailsPage(),
                                );
                              },
                              length: state.clusters.length,
                              index: state.selectedIndex,
                              onIndexChanged: (int index) {
                                context.read<StoryPagerBloc>().add(
                                  StoryPagerIndexChanged(index),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve:
                          _toolBarVisible
                              ? Curves.easeInOutBack
                              : Curves.easeOut,
                      bottom:
                          _toolBarVisible
                              ? MediaQuery.paddingOf(context).bottom + 4
                              : -100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: StoryPagerToolbar(
                          isPreviousEnabled: state.selectedIndex > 0,
                          isNextEnabled:
                              state.selectedIndex < state.clusters.length - 1,
                          onPrevious:
                              () => context.read<StoryPagerBloc>().add(
                                const StoryPagerPreviousPressed(),
                              ),
                          onNext:
                              () => context.read<StoryPagerBloc>().add(
                                const StoryPagerNextPressed(),
                              ),
                          onList: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
