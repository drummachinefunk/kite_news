import 'package:flutter/material.dart';
import 'package:kagi_news/features/story_details/utilities/item_data.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key, required this.title, required this.items});

  final String title;
  final List<ItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TimelineListTile(data: items[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: items.length,
        ),
      ],
    );
  }
}

class TimelineListTile extends StatelessWidget {
  const TimelineListTile({super.key, required this.data});

  final ItemData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
        ),
        const SizedBox(height: 4),
        Text(data.text),
      ],
    );
  }
}
