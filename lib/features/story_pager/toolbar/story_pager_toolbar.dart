import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryPagerToolbar extends StatelessWidget {
  const StoryPagerToolbar({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.onList,
    this.isPreviousEnabled = true,
    this.isNextEnabled = true,
  });

  final bool isPreviousEnabled;
  final bool isNextEnabled;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(100),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(100),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: isPreviousEnabled ? onPrevious : null,
                child: const Icon(CupertinoIcons.arrow_left),
              ),
              CupertinoButton(onPressed: onList, child: const Icon(CupertinoIcons.list_bullet)),
              CupertinoButton(
                onPressed: isNextEnabled ? onNext : null,
                child: const Icon(CupertinoIcons.arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
