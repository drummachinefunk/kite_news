import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage(this.imageUrl, {super.key, this.size = 20});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 24),
      ),
    );
  }
}
