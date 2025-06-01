import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  const BulletList({super.key, required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return BulletListItem(text: items[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: items.length,
        ),
      ],
    );
  }
}

class BulletListItem extends StatelessWidget {
  const BulletListItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [const Text('•'), const SizedBox(width: 4), Expanded(child: Text(text))],
    );
  }
}
