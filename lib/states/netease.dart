import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/ncmapi/ncmapi.dart';

final personalizedPlaylistProvider = FutureProvider((ref) async {
  final result = await NeteaseCloudMusicAPI().fetchPersonalizedPlaylist(limit: 6);
  return result.asFuture;
});

final personalizedNewSongProvider = FutureProvider((ref) async {
  final result = await NeteaseCloudMusicAPI().fetchPersonalizedNewSong(limit: 10);
  return result.asFuture;
});