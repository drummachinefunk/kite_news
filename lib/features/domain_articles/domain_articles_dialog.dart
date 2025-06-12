import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kagi_news/features/domain_articles/components/article_tile.dart';
import 'package:kagi_news/features/domain_articles/domain_articles_bloc.dart';
import 'package:kagi_news/features/navigation/navigation.dart';
import 'package:kagi_news/localization/localization.dart';

class DomainArticlesDialog extends StatelessWidget {
  const DomainArticlesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DomainArticlesBloc, DomainArticlesState>(
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 8, backgroundImage: NetworkImage(state.source.favicon)),
                    const SizedBox(width: 12),
                    Text(state.source.name, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (index >= state.source.articles.length) return const SizedBox.shrink();
                    final article = state.source.articles[index];
                    return ArticleTile(
                      title: article.title,
                      subtitle: DateFormat.yMMMd().format(article.date),
                      onPressed: () => presentUrl(article.link),
                    );
                  },
                  itemCount: state.source.articles.length,
                  shrinkWrap: true,
                ),

                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(L.of(context).close),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
