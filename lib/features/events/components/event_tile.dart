import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kagi_news/models/event.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event, this.onLinkTapped});

  final Event event;
  final void Function(String url)? onLinkTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                event.type == EventType.event ? Icons.event : Icons.person,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(event.year, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          Html(
            shrinkWrap: true,
            style: {
              'body': Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                fontSize: FontSize(Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0),
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              'a': Style(
                color: Theme.of(context).colorScheme.primary,
                textDecoration: TextDecoration.none,
              ),
            },
            onLinkTap: (url, attributes, element) {
              if (url == null) return;
              onLinkTapped?.call(url);
            },
            data: event.content,
          ),
        ],
      ),
    );
  }
}
