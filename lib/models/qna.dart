import 'package:json_annotation/json_annotation.dart';

part 'qna.g.dart';

@JsonSerializable()
class Qna {
  final String question;
  final String answer;

  Qna({required this.question, required this.answer});

  factory Qna.fromJson(Map<String, dynamic> json) => _$QnaFromJson(json);

  Map<String, dynamic> toJson() => _$QnaToJson(this);
}
