import 'package:flutter/material.dart';
import 'package:kagi_news/features/navigation/navigation.dart';

class QuoteBox extends StatelessWidget {
  const QuoteBox({super.key, required this.title, required this.text, this.author, this.source});

  final String? title;
  final String text;
  final String? author;
  final String? source;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
          ],
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
          if (author != null) ...[
            if (source != null) ...[
              TextButton(
                onPressed: () => presentUrl(source!),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                  minimumSize: WidgetStateProperty.all(Size.zero),
                ),
                child: Text(author!),
              ),
            ] else ...[
              Text(
                author!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ]
        ],
      ),
    );
  }
}
