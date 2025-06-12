import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kagi_news/components/loading_indicator.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/features/home/home_bloc.dart';
import 'package:kagi_news/features/category_tab/category_tab.dart';
import 'package:kagi_news/features/category_tab/category_tab_bloc.dart';
import 'package:kagi_news/navigation/navigation.dart';
import 'package:kagi_news/localization/localization.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/models/category.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen:
          (previous, current) =>
              (previous is! HomeStateLoaded && current is HomeStateLoaded) ||
              (previous is HomeStateLoaded &&
                  current is HomeStateLoaded &&
                  (previous.categories != current.categories ||
                      previous.category != current.category)),
      listener: (context, state) {
        if (state is HomeStateLoaded) {
          _updateTabController(
            state.categories,
            state.category,
            state.categories.indexOf(state.category),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeStateError(:final message):
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(message, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton(onPressed: () {}, child: Text(L.of(context).reload)),
                    ],
                  ),
                ),
              );
            case HomeStateLoaded(:final categories, :final category, :final date):
              int? index = categories.indexOf(category);
              if (index == -1) index = 0;

              return Scaffold(
                body: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      TitleBar(
                        leading: IconButton(
                          padding: const EdgeInsets.all(2),
                          onPressed: () => presentInfo(context),
                          icon: SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? 'assets/kite.svg'
                                : 'assets/kite_dark.svg',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        title: Text(date),
                        trailing: IconButton(
                          onPressed: () => presentSettings(context),
                          icon: const Icon(Icons.settings),
                        ),
                      ),
                      Row(
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
                      Expanded(child: _buildCategoryTabs(state.categories)),
                    ],
                  ),
                ),
              );
            default:
              return const Center(child: LoadingIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCategoryTabs(List<Category> categories) {
    return categories.isNotEmpty
        ? Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    categories.asMap().entries.map((e) {
                      return BlocProvider(
                        create:
                            (context) => CategoryTabBloc(
                              category: e.value,
                              newsRepository: locator<NewsRepository>(),
                            )..add(const CategoryTabStarted()),
                        child: CategoryTab(
                          onSelected:
                              (clusters, index) =>
                                  presentCategory(context, e.value, clusters, index),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        )
        : Container();
  }
}
