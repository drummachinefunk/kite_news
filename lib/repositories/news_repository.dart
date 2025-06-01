import 'package:dio/dio.dart';
import 'package:kagi_news/models/categories_response.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/category_response.dart';

class NewsRepository {
  static const baseUrl = 'https://kite.kagi.com';
  static const categoriesFile = 'kite.json';
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
}
