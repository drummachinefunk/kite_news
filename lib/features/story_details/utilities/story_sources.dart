import 'package:kagi_news/features/story_details/models/source_item.dart';
import 'package:kagi_news/models/cluster.dart';

List<SourceItem> getStorySources(Cluster cluster) {
  final sources =
      cluster.domains
          .map((domain) {
            final articlesForDomain =
                cluster.articles
                    .where((article) => article.domain == domain.name)
                    .toList();
            return SourceItem(
              name: domain.name,
              favicon: domain.favicon,
              articles: articlesForDomain,
            );
          })
          .where((source) => source.articles.isNotEmpty)
          .toList();
  return sources;
}
