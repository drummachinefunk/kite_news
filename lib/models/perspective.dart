import 'package:json_annotation/json_annotation.dart';
import 'package:kagi_news/models/source.dart';

part 'perspective.g.dart';

@JsonSerializable()
class Perspective {
  final String text;
  final List<Source> sources;

  const Perspective({required this.text, required this.sources});

  factory Perspective.fromJson(Map<String, dynamic> json) => _$PerspectiveFromJson(json);

  Map<String, dynamic> toJson() => _$PerspectiveToJson(this);
}
