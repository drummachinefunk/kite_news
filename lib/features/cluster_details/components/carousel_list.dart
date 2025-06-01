import 'package:flutter/material.dart';

class CarouselListItemData {
  final String text;
  final String url;
  final String source;

  const CarouselListItemData({required this.text, required this.url, required this.source});
}

class CarouselList extends StatelessWidget {
  const CarouselList({super.key, required this.title, required this.items});

  final List<CarouselListItemData> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.text, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4.0),
                      TextButton(onPressed: () {}, child: Text(item.source)),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
