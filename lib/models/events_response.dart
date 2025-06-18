import 'package:json_annotation/json_annotation.dart';
import 'package:kagi_news/models/event.dart';

part 'events_response.g.dart';

@JsonSerializable()
class EventsResponse {
  final int timestamp;
  final List<Event> events;

  const EventsResponse({required this.timestamp, required this.events});

  factory EventsResponse.fromJson(Map<String, dynamic> json) => _$EventsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventsResponseToJson(this);
}
