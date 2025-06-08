import 'package:flutter/cupertino.dart';

class SliverSpacing extends SliverToBoxAdapter {
  SliverSpacing({super.key, double height = 20.0}) : super(child: SizedBox(height: height));
}
