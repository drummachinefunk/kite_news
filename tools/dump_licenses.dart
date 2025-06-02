import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final licenses = <String>[];

  await for (final entry in LicenseRegistry.licenses) {
    final packages = entry.packages.join(', ');
    final body = entry.paragraphs.map((p) => p.text).join('\n\n');

    licenses.add('## $packages\n\n$body');
  }

  final markdown = licenses.join('\n\n---\n\n');
  await File('assets/acknowledgements.md').writeAsString(markdown);

  debugPrint('✅ assets/acknowledgements.md written.');

  exit(0);
}
