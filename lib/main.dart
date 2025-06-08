import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/home/home_bloc.dart';
import 'package:kagi_news/features/home/home_page.dart';
import 'package:kagi_news/locator.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:kagi_news/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const KiteApp());
}

class KiteApp extends StatelessWidget {
  const KiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kite News',
      debugShowCheckedModeBanner: false,
      theme: KagiTheme.createLightTheme(),
      darkTheme: KagiTheme.createDarkTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create:
            (context) =>
                HomeBloc(newsRepository: locator<NewsRepository>())..add(const HomeStarted()),
        child: const HomePage(),
      ),
    );
  }
}
