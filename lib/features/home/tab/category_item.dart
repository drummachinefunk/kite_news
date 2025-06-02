import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kagi_news/models/cluster.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.cluster, this.onTap});

  final Cluster cluster;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cluster.category, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4.0),
          Text(cluster.title, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
