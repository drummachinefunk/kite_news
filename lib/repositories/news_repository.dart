import 'package:dio/dio.dart';
import 'package:kagi_news/models/categories_response.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/category_response.dart';
import 'package:kagi_news/models/events_response.dart';

enum CategoryType { stories, events }

class NewsRepository {
  static const baseUrl = 'https://kite.kagi.com';
  static const categoriesFile = 'kite.json';
  static const onThisDayFile = 'onthisday.json';
  final dio = Dio();

  Future<CategoriesResponse> loadCategories() async {
    const url = '$baseUrl/$categoriesFile';
    final result = await dio.get(url);
    final response = CategoriesResponse.fromJson(result.data);
    return response;
  }

  Future<CategoryResponse> loadCategory(Category category) async {
    final url = '$baseUrl/${category.file}';
    final result = await dio.get(url);
    final response = CategoryResponse.fromJson(result.data);
    return response;
  }

  Future<EventsResponse> loadEvents() async {
    const url = '$baseUrl/$onThisDayFile';
    final result = await dio.get(url);
    final response = EventsResponse.fromJson(result.data);
    return response;
  }

  static CategoryType getCategoryType(Category category) {
    if (category.file == onThisDayFile) {
      return CategoryType.events;
    }
    return CategoryType.stories;
  }
}
