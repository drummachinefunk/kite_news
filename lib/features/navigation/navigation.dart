import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/story_pager/story_pager.dart';
import 'package:kagi_news/features/story_pager/story_pager_bloc.dart';
import 'package:kagi_news/features/info/info_bloc.dart';
import 'package:kagi_news/features/info/info_page.dart';
import 'package:kagi_news/features/settings/settings_bloc.dart';
import 'package:kagi_news/features/settings/settings_page.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';

void presentCategory(BuildContext context, Category category, List<Cluster> clusters, int index) {
  Navigator.push(
    context,
    CupertinoModalPopupRoute(
      builder:
          (context) => BlocProvider(
            create:
                (context) =>
                    StoryPagerBloc(category: category, clusters: clusters, index: index)
                      ..add(const StoryPagerStarted()),
            child: StoryPager(
              onDismiss: () {
                Navigator.of(context).pop();
              },
            ),
          ),
    ),
  );
}

void presentSettings(BuildContext context) {
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

void presentInfo(BuildContext context) {
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
