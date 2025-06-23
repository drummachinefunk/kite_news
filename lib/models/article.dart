import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable {
  final String title;
  final String link;
  final String domain;
  //@JsonKey(fromJson: _dateFromJson)
  final DateTime date;
  final String image;
  @JsonKey(name: 'image_caption')
  final String imageCaption;

  const Article({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
    required this.imageCaption,
  });

  @override
  List<Object?> get props => [title, link, domain, date, image, imageCaption];

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
