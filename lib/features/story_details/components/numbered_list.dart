import 'package:flutter/material.dart';
import 'package:kagi_news/features/story_details/utilities/item_data.dart';

class NumberedList extends StatelessWidget {
  const NumberedList({super.key, required this.title, required this.items});

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
            return NumberedListTile(index: index + 1, data: items[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: items.length,
        ),
      ],
    );
  }
}

class NumberedListTile extends StatelessWidget {
  const NumberedListTile({super.key, required this.index, required this.data});

  final int index;
  final ItemData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(child: Text(index.toString())),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(data.text)),
      ],
    );
  }
}
