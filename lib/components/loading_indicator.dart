import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS || Platform.isMacOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
