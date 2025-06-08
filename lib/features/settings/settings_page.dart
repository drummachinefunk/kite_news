import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/features/story_details/components/sliver_spacing.dart';
import 'package:kagi_news/features/story_details/components/sliver_with_padding.dart';
import 'package:kagi_news/features/info/info_bloc.dart';
import 'package:kagi_news/features/info/info_page.dart';
import 'package:kagi_news/features/settings/settings_bloc.dart';
import 'package:kagi_news/features/settings/settings_list_tile.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _presentAcknowledgements(BuildContext context) {
    
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        builder:
            (context) => BlocProvider(
              create:
                  (context) =>
                      InfoBloc(title: 'Acknowledgements', asset: 'assets/acknowledgements.md')
                        ..add(const InfoStarted()),
              child: const InfoPage(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TitleBar(
                  title: const Text('Settings'),
                  trailing: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return SettingsListTile(
                                  title: 'Kagi Search',
                                  onTap:
                                      () => launchUrlString(
                                        'https://kagi.com',
                                        mode: LaunchMode.externalApplication,
                                      ),
                                );
                              case 1:
                                return SettingsListTile(
                                  title: 'Acknowledgements',
                                  onTap: () => _presentAcknowledgements(context),
                                );
                              case 2:
                                return SettingsListTile(
                                  title: 'Feedback',
                                  onTap: () => launchUrlString('mailto:hello@drummachinefunk.com'),
                                );
                              case 3:
                                return SettingsListTile(
                                  title: 'Kagi Search',
                                  onTap: () => launchUrlString('https://kagi.com'),
                                );
                            }
                            return Container();
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: 3,
                        ),
                      ),
                      SliverSpacing(height: 50),
                      SliverWithPadding(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Developed with love by',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            CupertinoButton(
                              onPressed: () => launchUrlString('https://drummachinefunk.com'),
                              child: SvgPicture.asset(
                                'assets/dmf_logo.svg',
                                width: 80,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (state.appVersion.isNotEmpty)
                              Text(
                                'App version: ${state.appVersion}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                          ],
                        ),
                      ),
                    ],
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
