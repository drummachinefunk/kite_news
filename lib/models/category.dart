import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final String name;
  final String file;

  const Category({required this.name, required this.file});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [name, file];

  @override
  String toString() => 'Category(name: $name, file: $file)';
}
