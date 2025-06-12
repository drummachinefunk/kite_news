import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qna.g.dart';

@JsonSerializable()
class Qna extends Equatable {
  final String question;
  final String answer;

  const Qna({required this.question, required this.answer});

  factory Qna.fromJson(Map<String, dynamic> json) => _$QnaFromJson(json);

  Map<String, dynamic> toJson() => _$QnaToJson(this);

  @override
  List<Object?> get props => [question, answer];
}
