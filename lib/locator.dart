import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_news/repositories/news_repository.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton<BaseCacheManager>(DefaultCacheManager());
  locator.registerSingleton(NewsRepository());
}
