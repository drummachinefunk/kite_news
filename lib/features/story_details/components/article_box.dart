import 'package:flutter/material.dart';
import 'package:kagi_news/components/web_image.dart';
import 'package:kagi_news/navigation/navigation.dart';

class ArticleBox extends StatelessWidget {
  const ArticleBox({
    super.key,
    required this.imageUrl,
    required this.caption,
    required this.source,
    required this.url,
  });

  final String imageUrl;
  final String caption;
  final String source;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => presentUrl(url),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: WebImage(imageUrl),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface.withAlpha(200),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        source,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (caption.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              caption,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ],
      ),
    );
  }
}
