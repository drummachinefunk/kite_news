import 'package:get_it/get_it.dart';
import 'package:kagi_news/repositories/news_repository.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton(NewsRepository());
}
