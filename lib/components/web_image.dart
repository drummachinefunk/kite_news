import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:kagi_news/locator.dart';

class WebImage extends StatelessWidget {
  const WebImage(this.imageUrl, {super.key, this.width, this.height});

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: locator<BaseCacheManager>(),
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return const Icon(Icons.error, size: 24);
      },
    );
    // return Image.network(
    //   imageUrl,
    //   width: width,
    //   height: height,
    //   fit: BoxFit.cover,
    //   errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 24),
    // );
  }
}
