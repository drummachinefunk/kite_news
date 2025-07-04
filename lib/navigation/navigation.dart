import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/domain_articles/domain_articles_bloc.dart';
import 'package:kagi_news/features/domain_articles/domain_articles_dialog.dart';
import 'package:kagi_news/features/story_details/models/source_item.dart';
import 'package:kagi_news/features/story_pager/story_pager.dart';
import 'package:kagi_news/features/story_pager/story_pager_bloc.dart';
import 'package:kagi_news/features/info/info_bloc.dart';
import 'package:kagi_news/features/info/info_page.dart';
import 'package:kagi_news/features/settings/settings_bloc.dart';
import 'package:kagi_news/features/settings/settings_page.dart';
import 'package:kagi_news/localization/localization.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:url_launcher/url_launcher_string.dart';

void presentCategory(
  BuildContext context,
  Category category,
  List<Cluster> clusters,
  int index,
) {
  Navigator.push(
    context,
    CupertinoModalPopupRoute(
      builder:
          (context) => BlocProvider(
            create:
                (context) => StoryPagerBloc(
                  category: category,
                  clusters: clusters,
                  index: index,
                )..add(const StoryPagerStarted()),
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
          (popupContext) => BlocProvider(
            create:
                (blocContext) => InfoBloc(
                  title: L.of(context).about,
                  asset: 'assets/info.md',
                )..add(const InfoStarted()),
            child: const InfoPage(),
          ),
    ),
  );
}

void presentAcknowledgements(BuildContext context) {
  Navigator.push(
    context,
    CupertinoModalPopupRoute(
      builder:
          (popupContext) => BlocProvider(
            create:
                (blocContext) => InfoBloc(
                  title: L.of(context).acknowledgements,
                  asset: 'assets/acknowledgements.md',
                )..add(const InfoStarted()),
            child: const InfoPage(),
          ),
    ),
  );
}

void presentUrl(String url, {bool isExternal = false}) async {
  try {
    await launchUrlString(
      url,
      mode:
          isExternal ? LaunchMode.externalApplication : LaunchMode.inAppWebView,
    );
  } catch (error) {
    debugPrint('Failed to launch URL: $url $error');
  }
}

void mailTo(String email, {String subject = ''}) async {
  final url = 'mailto:$email?subject=${Uri.encodeComponent(subject)}';
  try {
    await launchUrlString(url);
  } catch (error) {
    debugPrint('Failed to launch mailto: $url $error');
  }
}

void presentDomainArticles(BuildContext context, SourceItem sourceItem) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder:
        (context) => BlocProvider(
          create:
              (context) =>
                  DomainArticlesBloc(sourceItem)
                    ..add(const DomainArticlesStarted()),
          child: const Dialog(child: DomainArticlesDialog()),
        ),
  );
}
