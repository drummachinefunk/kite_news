import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/carousel.dart';
import 'package:kagi_news/components/custom_tabbar.dart';
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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _isFocused = false;

  void _pushCarousel(BuildContext context, List<Cluster> clusters, int index) {
    setState(() {
      _isFocused = true;
    });
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   scrollControlDisabledMaxHeightRatio: 0.88,
    //   builder: (context) {
    //     return DraggableScrollableSheet(
    //       initialChildSize: 0.88,
    //       expand: false,
    //       builder: (context, scrollController) {
    //         return BlocProvider(
    //           create:
    //               (context) =>
    //                   ClusterCarouselBloc(clusters: clusters, index: index)
    //                     ..add(const ClusterCarouselStarted()),
    //           child: ClusterCarousel(scrollController: scrollController),
    //         );
    //       },
    //     );
    //   },
    // );
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.88,
      barrierColor: Colors.transparent,
      builder: (context) {
        return BlocProvider(
          create:
              (context) =>
                  ClusterCarouselBloc(clusters: clusters, index: index)
                    ..add(const ClusterCarouselStarted()),
          child: ClusterCarousel(
            onDismiss: () {
              setState(() => _isFocused = false);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    // Navigator.push(
    //   context,
    //   CupertinoModalPopupRoute(
    //     builder:
    //         (context) => BlocProvider(
    //           create:
    //               (context) =>
    //                   ClusterCarouselBloc(clusters: clusters, index: index)
    //                     ..add(const ClusterCarouselStarted()),
    //           child: const ClusterCarousel(),
    //         ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
                        child: DefaultTabController(
                          length: state.categories.length,
                          initialIndex: index,

                          // child: SizedBox(
                          //   height: 50,
                          //   child: CustomTabBar(
                          //     tabs: state.categories.map((e) => e.name).toList(),
                          //     selectedIndex: state.categories.indexOf(state.category),
                          //     focusedIndex:
                          //         _isFocused ? state.categories.indexOf(state.category) : -1,
                          //     onDismiss: () {
                          //       setState(() => _isFocused = false);
                          //       //Navigator.of(context).pop();
                          //     },
                          //   ),
                          // ),
                          child: TabBar(
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
                      ),
                      // FilledButton(
                      //   onPressed: () => context.read<HomeBloc>().add(const HomePrevPressed()),
                      //   child: const Icon(Icons.arrow_back),
                      // ),
                      // const SizedBox(width: 8),
                      // Expanded(
                      //   child: FilledButton(onPressed: () {}, child: Text(state.category.name)),
                      // ),
                      // const SizedBox(width: 8),
                      // FilledButton(
                      //   onPressed: () => context.read<HomeBloc>().add(const HomeNextPressed()),
                      //   child: const Icon(Icons.arrow_forward),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      state.categories.isNotEmpty
                          ? Carousel(
                            length: state.categories.length,
                            itemBuilder: (context, index) {
                              return BlocProvider(
                                create:
                                    (context) => CategoryTabBloc(
                                      category: state.categories[index],
                                      newsRepository: locator<NewsRepository>(),
                                    )..add(const CategoryTabStarted()),
                                child: CategoryTab(
                                  onSelected:
                                      (clusters, index) => _pushCarousel(context, clusters, index),
                                ),
                              );
                            },
                            index: state.categories.indexOf(state.category),
                            onIndexChanged: (int index) {
                              context.read<HomeBloc>().add(
                                HomeCategoryChanged(state.categories[index]),
                              );
                            },
                          )
                          : Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
