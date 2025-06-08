import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kagi_news/models/article.dart';

class SourceItem {
  final String name;
  final String favicon;
  final List<Article> articles;
  const SourceItem({required this.name, required this.favicon, required this.articles});
}

class Sources extends StatelessWidget {
  const Sources({super.key, required this.sources});

  final List<SourceItem> sources;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        final source = sources[index];
        return SourceListTile(source: source);
      },
      itemCount: sources.length,
    );
  }
}

class SourceListTile extends StatelessWidget {
  const SourceListTile({super.key, required this.source});

  final SourceItem source;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(radius: 8, backgroundImage: NetworkImage(source.favicon)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(source.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(
                '${source.articles.length} articles',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
