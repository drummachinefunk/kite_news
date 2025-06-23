import 'package:json_annotation/json_annotation.dart';
import 'package:kagi_news/models/cluster.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  final String category;
  final int timestamp;
  final int read;
  final List<Cluster> clusters;

  const CategoryResponse({
    required this.category,
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
