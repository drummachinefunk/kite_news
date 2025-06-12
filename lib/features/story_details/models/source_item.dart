import 'package:equatable/equatable.dart';
import 'package:kagi_news/models/article.dart';

class SourceItem extends Equatable {
  final String name;
  final String favicon;
  final List<Article> articles;
  const SourceItem({required this.name, required this.favicon, required this.articles});

  @override
  List<Object?> get props => [name, favicon, articles];

  @override
  String toString() {
    return 'SourceItem(name: $name, favicon: $favicon, articles: ${articles.length})';
  }
}
