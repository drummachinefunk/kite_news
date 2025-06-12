import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'domain.g.dart';

@JsonSerializable()
class Domain extends Equatable {
  final String name;
  final String favicon;

  const Domain({required this.name, required this.favicon});

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);

  Map<String, dynamic> toJson() => _$DomainToJson(this);

  @override
  List<Object?> get props => [name, favicon];
}
