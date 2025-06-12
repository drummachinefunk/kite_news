import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kagi_news/components/circle_image.dart';
import 'package:kagi_news/features/story_details/models/source_item.dart';
import 'package:kagi_news/localization/localization.dart';

class Sources extends StatelessWidget {
  const Sources({
    super.key,
    required this.sources,
    this.expanded = false,
    this.onToggleExpanded,
    required this.onSourceSelected,
  }) : maxSources = expanded ? sources.length : collapseSourcesCount;

  static const int collapseSourcesCount = 5;

  final List<SourceItem> sources;
  final bool expanded;
  final int maxSources;
  final VoidCallback? onToggleExpanded;
  final void Function(SourceItem source) onSourceSelected;

  @override
  Widget build(BuildContext context) {
    final visibleItemCount = expanded ? sources.length : min(collapseSourcesCount, sources.length);
    final showMoreButton =
        expanded ? sources.length > collapseSourcesCount : sources.length > visibleItemCount;

    return SliverList.builder(
      itemBuilder: (context, index) {
        if (index == visibleItemCount) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: CupertinoButton(
              key: const Key('show_more_button'),
              alignment: Alignment.centerLeft,
              onPressed: () => onToggleExpanded?.call(),
              child: Text(
                expanded ? L.of(context).showLess : L.of(context).showMore,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }
        final source = sources[index];
        return SourceListTile(source: source, onPressed: () => onSourceSelected.call(source));
      },
      itemCount: visibleItemCount + (showMoreButton ? 1 : 0),
    );
  }
}

class SourceListTile extends StatelessWidget {
  const SourceListTile({super.key, required this.source, required this.onPressed});

  final SourceItem source;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onPressed: onPressed,

      child: Row(
        children: [
          CircleImage(source.favicon),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(source.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(
                L.of(context).numberOfArticles(source.articles.length),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
