import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:mixin_logger/mixin_logger.dart';

abstract class Key {
  factory Key.fromString(String key) {
    return _StringKey(key);
  }

  ///unique key to save or get a cache
  String getKey();
}

class _StringKey implements Key {
  const _StringKey(this.key);

  final String key;

  @override
  String getKey() {
    return key;
  }
}

abstract class Cache<T> {
  ///get cache object by key
  ///null if no cache
  Future<T> get(Key key);

  ///update cache by key
  ///true if success
  Future<bool> update(Key key, T t);
}

class FileCacheProvider {
  FileCacheProvider(this.directory, { required this.maxSize});

  final String directory;
  final int maxSize;

  bool _calculating = false;

  File _cacheFileForKey(Key key) => File(p.join(directory, key.getKey()));

  File getFile(Key key) {
    return _cacheFileForKey(key);
  }

  void touchFile(File file) {
    file.setLastModified(DateTime.now()).catchError((e) {
      debugPrint('setLastModified for ${file.path} failed. $e');
    });
  }

  void checkSize() {
    if (_calculating) {
      return;
    }
    _calculating = true;
    compute(
      _fileLru,
      {'path': directory, 'maxSize': maxSize},
      debugLabel: 'file lru check size',
    ).whenComplete(() {
      _calculating = false;
    });
  }
}


Future<void> _fileLru(Map<String, dynamic> params) async {
  final directory = Directory(params['path'] as String);
  final maxSize = params['maxSize'] as int?;
  if (!directory.existsSync()) {
    return;
  }
  final files = directory.listSync().whereType<File>().toList();
  files.sort((a, b) {
    try {
      return a.lastModifiedSync().compareTo(b.lastModifiedSync());
    } catch (error, stacktrace) {
      e('_fileLru: error: $error, stacktrace: $stacktrace');
      return 0;
    }
  });

  var totalSize = 0;
  for (final file in files) {
    if (totalSize > maxSize!) {
      file.deleteSync();
    } else {
      totalSize += file.lengthSync();
    }
  }
}