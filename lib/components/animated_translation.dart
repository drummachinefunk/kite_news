import 'package:flutter/material.dart';

class AnimatedTranslation extends StatelessWidget {
  final Offset offset;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedTranslation({
    super.key,
    required this.offset,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: Offset.zero, end: offset),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(offset: value, child: child);
      },
      child: child,
    );
  }
}