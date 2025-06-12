import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kagi_news/components/title_bar.dart';
import 'package:kagi_news/navigation/navigation.dart';
import 'package:kagi_news/features/story_details/components/sliver_spacing.dart';
import 'package:kagi_news/features/story_details/components/sliver_with_padding.dart';
import 'package:kagi_news/features/settings/settings_bloc.dart';
import 'package:kagi_news/features/settings/components/settings_list_tile.dart';
import 'package:kagi_news/localization/localization.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TitleBar(
                  title: Text(L.of(context).settings),
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
                                  title: L.of(context).kagiSearch,
                                  onTap: () => presentUrl('https://kagi.com', isExternal: true),
                                );
                              case 1:
                                return SettingsListTile(
                                  title: L.of(context).acknowledgements,
                                  onTap: () => presentAcknowledgements(context),
                                );
                              case 2:
                                return SettingsListTile(
                                  title: L.of(context).feedback,
                                  onTap:
                                      () => mailTo(
                                        'hello@drummachinefunk.com',
                                        subject: 'Feedback for Kagi News',
                                      ),
                                );
                              default:
                                return Container();
                            }
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
                              L.of(context).developedWithLove,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            CupertinoButton(
                              onPressed:
                                  () => presentUrl('https://drummachinefunk.com', isExternal: true),
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
                                '${L.of(context).appVersion}: ${state.appVersion}',
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
