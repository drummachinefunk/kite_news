import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key, required this.title, this.leading, this.trailing, this.padding});

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Stack(
        alignment: Alignment.center,
        children: [
          DefaultTextStyle(style: Theme.of(context).textTheme.titleLarge!, child: title),
          Row(
            children: [
              if (leading != null) leading!,
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ],
      ),
    );
  }
}
