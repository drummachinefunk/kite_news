// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perspective.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Perspective _$PerspectiveFromJson(Map<String, dynamic> json) => Perspective(
  text: json['text'] as String,
  sources:
      (json['sources'] as List<dynamic>)
          .map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PerspectiveToJson(Perspective instance) =>
    <String, dynamic>{'text': instance.text, 'sources': instance.sources};
