import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

enum EventType { event, people }

@JsonSerializable()
class Event extends Equatable {
  final String year;
  final String content;
  @JsonKey(name: 'sort_year')
  final double sortYear;
  final EventType type;

  const Event({
    required this.year,
    required this.content,
    required this.sortYear,
    required this.type,
  });

  @override
  List<Object?> get props => [year, content, sortYear, type];

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
