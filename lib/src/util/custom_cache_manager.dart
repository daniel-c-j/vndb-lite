import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:file/local.dart';
import 'package:file/file.dart' hide FileSystem;
import 'package:flutter_cache_manager/src/storage/file_system/file_system.dart' as c;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// TODO

class IOFileSystem implements c.FileSystem {
  const IOFileSystem(this._cacheKey);

  final String _cacheKey;

  static Future<Directory> createDirectory(String key) async {
    // ! Use documents directory instead of temp directory.
    final baseDir = await getApplicationDocumentsDirectory();
    final path = p.join(baseDir.path, key);

    const fs = LocalFileSystem();
    final directory = fs.directory((path));

    await directory.create(recursive: true);
    return directory;
  }

  @override
  Future<File> createFile(String name) async {
    final directory = await createDirectory(_cacheKey);
    if (!(await directory.exists())) await createDirectory(_cacheKey);

    return directory.childFile(name);
  }
}

class CustomCacheManager extends CacheManager with ImageCacheManager {
  static const String key = "vndb_lite_cache";

  CustomCacheManager() : super(Config(key, fileSystem: const IOFileSystem(key)));
}
