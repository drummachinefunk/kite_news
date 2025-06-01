import 'package:json_annotation/json_annotation.dart';
import 'package:kagi_news/models/category.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final int timestamp;
  final List<Category> categories;

  const CategoriesResponse({required this.timestamp, required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
