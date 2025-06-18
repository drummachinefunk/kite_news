// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  year: json['year'] as String,
  content: json['content'] as String,
  sortYear: (json['sort_year'] as num).toDouble(),
  type: $enumDecode(_$EventTypeEnumMap, json['type']),
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'year': instance.year,
  'content': instance.content,
  'sort_year': instance.sortYear,
  'type': _$EventTypeEnumMap[instance.type]!,
};

const _$EventTypeEnumMap = {
  EventType.event: 'event',
  EventType.people: 'people',
};
