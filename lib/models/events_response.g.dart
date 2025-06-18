// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsResponse _$EventsResponseFromJson(Map<String, dynamic> json) =>
    EventsResponse(
      timestamp: (json['timestamp'] as num).toInt(),
      events:
          (json['events'] as List<dynamic>)
              .map((e) => Event.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$EventsResponseToJson(EventsResponse instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'events': instance.events,
    };
