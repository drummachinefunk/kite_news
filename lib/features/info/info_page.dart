import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/features/info/info_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TitleBar(
                  title: Text(state.title),
                  trailing: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index >= state.markdown.length) return const SizedBox.shrink();
                      final part = state.markdown[index];
                      return Markdown(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        styleSheet: MarkdownStyleSheet(
                          h1Padding: const EdgeInsets.symmetric(vertical: 4),
                          h2Padding: const EdgeInsets.symmetric(vertical: 2),
                          h3Padding: const EdgeInsets.symmetric(vertical: 1),
                        ),
                        data: part,
                        onTapLink: (text, href, title) {
                          try {
                            if (href != null) launchUrl(Uri.parse(href));
                          } catch (_) {}
                        },
                      );
                    },
                    itemCount: state.markdown.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
