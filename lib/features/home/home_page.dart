import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel.dart';
import 'package:kagi_news/features/cluster_carousel/cluster_carousel_bloc.dart';
import 'package:kagi_news/features/home/home_bloc.dart';
import 'package:kagi_news/features/home/tab/category_tab.dart';
import 'package:kagi_news/features/home/tab/category_tab_bloc.dart';
import 'package:kagi_news/features/info/info_bloc.dart';
import 'package:kagi_news/features/info/info_page.dart';
import 'package:kagi_news/features/settings/settings_bloc.dart';
import 'package:kagi_news/features/settings/settings_page.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:kagi_news/repositories/news_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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

  void _pushCarousel(BuildContext context, Category category, List<Cluster> clusters, int index) {
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        builder:
            (context) => BlocProvider(
              create:
                  (context) =>
                      ClusterCarouselBloc(category: category, clusters: clusters, index: index)
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

  void _presentSettings(BuildContext context) {
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        builder:
            (context) => BlocProvider(
              create: (context) => SettingsBloc()..add(const SettingsStarted()),
              child: const SettingsPage(),
            ),
      ),
    );
  }

  void _presentInfo(BuildContext context) {
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        builder:
            (context) => BlocProvider(
              create:
                  (context) =>
                      InfoBloc(title: 'About', asset: 'assets/info.md')..add(const InfoStarted()),
              child: const InfoPage(),
            ),
      ),
    );
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
                  TitleBar(
                    leading: IconButton(
                      padding: const EdgeInsets.all(2),
                      onPressed: () => _presentInfo(context),
                      icon: SvgPicture.asset('assets/kite.svg', width: 36, height: 36),
                    ),
                    title: Text(DateFormat('EEE, MMM dd').format(state.date)),
                    trailing: IconButton(
                      onPressed: () => _presentSettings(context),
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TabBar(
                            tabAlignment: TabAlignment.start,
                            controller: _tabController,
                            isScrollable: true,
                            tabs:
                                state.categories
                                    .map((category) => Tab(text: category.name))
                                    .toList(),
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
                                                  (clusters, index) => _pushCarousel(
                                                    context,
                                                    e.value,
                                                    clusters,
                                                    index,
                                                  ),
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
