import 'package:flutter/material.dart';
import 'package:kagi_news/features/navigation/navigation.dart';
import 'package:kagi_news/models/source.dart';

class Sources extends StatelessWidget {
  const Sources({super.key, required this.sources});

  final List<Source> sources;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final source = sources[index];
        return ListTile(title: Text(source.name), onTap: () => presentUrl(source.url));
      },
      itemCount: sources.length,
    );
  }
}
