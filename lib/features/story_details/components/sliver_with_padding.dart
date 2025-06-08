import 'package:flutter/cupertino.dart';

class SliverWithPadding extends SliverToBoxAdapter {
  SliverWithPadding({
    super.key,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16.0),
    required Widget child,
  }) : super(child: Padding(padding: padding, child: child));
}
