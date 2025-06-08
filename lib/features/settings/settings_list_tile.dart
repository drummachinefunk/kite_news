import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
