import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel_bloc.dart';
import 'package:kagi_news/features/home/home_bloc.dart';
import 'package:kagi_news/features/home/tab/category_tab.dart';
import 'package:kagi_news/features/home/tab/category_tab_bloc.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:kagi_news/repositories/news_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  void _pushCarousel(BuildContext context, List<Cluster> clusters, int index) {

    // showCupertinoSheet(
    //   context: context,
    //   pageBuilder: (context) {
    //     return BlocProvider(
    //       create:
    //           (context) =>
    //               ClusterCarouselBloc(clusters: clusters, index: index)
    //                 ..add(const ClusterCarouselStarted()),
    //       child: ClusterCarousel(
    //         onDismiss: () {
    //           setState(() => _isFocused = false);
    //           CupertinoSheetRoute.popSheet(context);
    //           //Navigator.of(context).pop();
    //         },
    //       ),
    //     );
    //   },
    // );

    // showModalBottomSheet(
    //   context: context,
    //   scrollControlDisabledMaxHeightRatio: 1.0,
    //   builder: (context) {
    //     return DraggableScrollableSheet(
    //       initialChildSize: 0.95,
    //       minChildSize: 0.95,
    //       maxChildSize: 0.95,
    //       expand: false,
    //       builder: (context, scrollController) {
    //         return BlocProvider(
    //           create:
    //               (context) =>
    //                   ClusterCarouselBloc(clusters: clusters, index: index)
    //                     ..add(const ClusterCarouselStarted()),
    //           child: ClusterCarousel(
    //             scrollController: scrollController,
    //             onDismiss: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
    // showModalBottomSheet(
    //   context: context,
    //   scrollControlDisabledMaxHeightRatio: 0.88,
    //   barrierColor: Colors.transparent,
    //   builder: (context) {
    //     return BlocProvider(
    //       create:
    //           (context) =>
    //               ClusterCarouselBloc(clusters: clusters, index: index)
    //                 ..add(const ClusterCarouselStarted()),
    //       child: ClusterCarousel(
    //         onDismiss: () {
    //           setState(() => _isFocused = false);
    //           Navigator.of(context).pop();
    //         },
    //       ),
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
              child: ClusterCarousel(
                onDismiss: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
      ),
    );
  }

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 0, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _updateTabController(List categories, dynamic category, int index) {
    if (_tabController!.length != categories.length) {
      _tabController?.dispose();
      _tabController = TabController(length: categories.length, initialIndex: 0, vsync: this);
    }
    if (_tabController!.index != index) {
      _tabController!.index = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        _updateTabController(
          state.categories,
          state.category,
          state.categories.indexOf(state.category),
        );
      },
      listenWhen:
          (previous, current) =>
              previous.categories.length != current.categories.length ||
              previous.category != current.category,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          int? index = state.categories.indexOf(state.category);
          if (index == -1) index = 0;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:
                          TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabs:
                                state.categories.map((category) {
                                  return Tab(text: category.name);
                                }).toList(),
                            onTap:
                                (value) => context.read<HomeBloc>().add(
                                  HomeCategoryChanged(state.categories[value]),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        state.categories.isNotEmpty
                            ? Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children:
                                        state.categories.asMap().entries.map((e) {
                                          return BlocProvider(
                                            create:
                                                (context) => CategoryTabBloc(
                                                  category: e.value,
                                                  newsRepository: locator<NewsRepository>(),
                                                )..add(const CategoryTabStarted()),
                                            child: CategoryTab(
                                              onSelected:
                                                  (clusters, index) =>
                                                      _pushCarousel(context, clusters, index),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ],
                            )
                            : Container(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
