import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class SliverImage extends StatelessWidget {
  const SliverImage({super.key, required this.url, required this.credits});

  final String url;
  final String credits;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(placeholder: Uint8List(0), image: url);
  }
}
