import 'dart:math';

import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.focusedIndex,
    required this.onDismiss,
  });

  final List<String> tabs;
  final int selectedIndex;
  final int focusedIndex;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomMultiChildLayout(
          delegate: Layout(length: tabs.length, focusedIndex: selectedIndex),
          children:
              tabs
                  .asMap()
                  .entries
                  .map(
                    (e) => LayoutId(
                      id: e.key,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: focusedIndex == -1 || focusedIndex == e.key ? 1.0 : 0.0,
                        child: TabButton(title: e.value, isSelected: e.key == selectedIndex),
                      ),
                    ),
                  )
                  .toList(),
        ),
        if (focusedIndex != -1)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('1 / 12'),
              const Spacer(),
              IconButton(onPressed: () => onDismiss(), icon: const Icon(Icons.close)),
            ],
          ),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({super.key, required this.title, this.isSelected = false});

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(title),
    );
  }
}

class Layout extends MultiChildLayoutDelegate {
  final int length;
  final int focusedIndex;

  final double padding = 8;

  Layout({required this.length, required this.focusedIndex});

  @override
  void performLayout(Size size) {
    final List<Size> sizes = List.filled(length, Size.zero);

    double offset = 0;
    double selectionOffset = 0;
    double maxHeight = 0;

    for (int i = 0; i < length; i++) {
      if (hasChild(i)) {
        final itemSize = layoutChild(i, BoxConstraints.loose(size));
        sizes[i] = itemSize;
        if (focusedIndex == i) {
          selectionOffset = offset + itemSize.width / 2;
        }
        offset += itemSize.width + padding;
        maxHeight = max(maxHeight, itemSize.height);
      }
    }

    offset = -selectionOffset + size.width / 2;
    final double y = (size.height - maxHeight) / 2;
    for (int i = 0; i < length; i++) {
      positionChild(i, Offset(offset, y));
      offset += sizes[i].width + padding;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
