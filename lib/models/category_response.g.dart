// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      category: json['category'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      read: (json['read'] as num).toInt(),
      clusters:
          (json['clusters'] as List<dynamic>)
              .map((e) => Cluster.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'timestamp': instance.timestamp,
      'read': instance.read,
      'clusters': instance.clusters,
    };
