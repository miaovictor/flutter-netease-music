import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:quiet/common/cache/cache.dart';
import 'package:quiet/ncmapi/models/personalized_newsong.dart';
import 'package:quiet/ncmapi/models/personalized_playlist.dart';
import 'package:quiet/ncmapi/request.dart';

const _kCodeSuccess = 200;

class NeteaseCloudMusicAPI {
  NeteaseCloudMusicAPI._();

  static final NeteaseCloudMusicAPI _instance = NeteaseCloudMusicAPI._();

  factory NeteaseCloudMusicAPI() => _instance;

  initialize() async {
    var documentDir = (await getApplicationDocumentsDirectory()).path;
    if (Platform.isWindows || Platform.isLinux) {
      documentDir = p.join(documentDir, 'quiet');
    }
    final cookiePath = p.join(documentDir, 'cookie');
    final cachePath = p.join(documentDir, 'cache');
    _lyricCache = _LyricCache(p.join(cachePath, 'lyrics'));

    scheduleMicrotask(() async {
      PersistCookieJar? cookieJar;
      try {
        cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));
      } catch (e) {
        debugPrint('error: can not create persist cookie jar');
      }
      _cookieJar.complete(cookieJar);
    });
  }

  _LyricCache? _lyricCache;
  Completer<PersistCookieJar> _cookieJar = Completer();

  Future<List<Cookie>> _loadCookies() async {
    final jar = await _cookieJar.future;
    final uri = Uri.parse('http://music.163.com');
    return jar.loadForRequest(uri);
  }

  Future<void> _saveCookies(List<Cookie> cookies) async {
    final jar = await _cookieJar.future;
    await jar.saveFromResponse(Uri.parse('http://music.163.com'), cookies);
  }

  // Future<Result<List<PersonalizedItem>>> fetchBanner({int limit = 30}) async {
  //   var data = {'limit': limit};
  //   final resp = await _doRequest(
  //       'POST', 'https://music.163.com/weapi/personalized/playlist', data);
  //   final ret = _map(resp, (t) => Personalized.fromJson(t));
  //   if (ret.isError) {
  //     return ret.asError!;
  //   }
  //   return Result.value(ret.asValue!.value.result);
  // }

  Future<Result<List<PersonalizedPlaylistItem>>> fetchPersonalizedPlaylist({int limit = 30}) async {
    var data = {'limit': limit};
    final resp = await _doRequest(
        'POST', 'https://music.163.com/weapi/personalized/playlist', data);
    final ret = _map(resp, (t) => PersonalizedPlaylist.fromJson(t));
    if (ret.isError) {
      return ret.asError!;
    }
    return Result.value(ret.asValue!.value.result);
  }

  Future<Result<List<PersonalizedNewSongItem>>> fetchPersonalizedNewSong({int limit = 10}) async {
    var data = {'limit': limit};
    final resp = await _doRequest(
        'POST', 'https://music.163.com/weapi/personalized/newsong', data);
    final ret = _map(resp, (t) => PersonalizedNewSong.fromJson(t));
    if (ret.isError) {
      return ret.asError!;
    }
    return Result.value(ret.asValue!.value.result);
  }

  Future<Result<Map<String, dynamic>>> _doRequest(String method, String url,
      [Map data = const {}]) async {
    Response resp;
    try {
      var cookie = await _loadCookies();
      resp = await request(method, url, data,
          crypto: Crypto.weapi, cookies: cookie);
    } catch (e, stacktrace) {
      debugPrint('request error : $e \n $stacktrace');
      final result = ErrorResult(e, stacktrace);
      return result;
    }

    if (resp.status == 200) {
      await _saveCookies(resp.cookie);
    }
    if (resp.body['code'] != _kCodeSuccess) {
      final error = ErrorResult(
        RequestError(
          code: resp.body['code'],
          message: resp.body['msg'] ?? resp.body['message'] ?? '请求失败了~',
          response: resp,
        ),
      );
      return error;
    } else {
      return Result.value(resp.body as Map<String, dynamic>);
    }
  }
}

Result<R> _map<R>(
    Result<Map<String, dynamic>> source,
    R Function(Map<String, dynamic> t) f,
    ) {
  if (source.isError) return source.asError!;
  try {
    return Result.value(f(source.asValue!.value));
  } catch (e, s) {
    return Result.error(e, s);
  }
}

class _LyricCache implements Cache<String?> {
  _LyricCache(String dir)
      : provider =
            FileCacheProvider(dir, maxSize: 20 * 1024 * 1024 /* 20 Mb */);
  final FileCacheProvider provider;

  @override
  Future<String?> get(Key key) async {
    final file = provider.getFile(key);
    if (await file.exists()) {
      provider.touchFile(file);
      return file.readAsStringSync();
    }
    return null;
  }

  @override
  Future<bool> update(Key key, String? t) async {
    var file = provider.getFile(key);
    if (await file.exists()) {
      await file.delete();
    }
    file = await file.create(recursive: true);
    await file.writeAsString(t!);
    try {
      return await file.exists();
    } finally {
      provider.checkSize();
    }
  }
}
