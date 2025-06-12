import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:file/local.dart';

class MockCacheManager extends Mock implements DefaultCacheManager {
  static const fileSystem = LocalFileSystem();

  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    yield FileInfo(
      fileSystem.file('./test/assets/placeholder.png'),
      FileSource.Cache,
      DateTime(2050),
      url,
    );
  }
}
