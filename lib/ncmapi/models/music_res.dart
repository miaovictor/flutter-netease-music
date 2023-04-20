import 'safe_convert.dart';

class MusicRes {
  MusicRes({
    this.name,
    this.id = 0,
    this.size = 0,
    this.extension = '',
    this.sr = 0,
    this.dfsId = 0,
    this.bitrate = 0,
    this.playTime = 0,
    this.volumeDelta = 0,
  });

  factory MusicRes.fromJson(Map<String, dynamic>? json) => MusicRes(
    name: asString(json, 'name'),
    id: asInt(json, 'id'),
    size: asInt(json, 'size'),
    extension: asString(json, 'extension'),
    sr: asInt(json, 'sr'),
    dfsId: asInt(json, 'dfsId'),
    bitrate: asInt(json, 'bitrate'),
    playTime: asInt(json, 'playTime'),
    volumeDelta: asInt(json, 'volumeDelta'),
  );
  final dynamic name;
  final int id;
  final int size;
  final String extension;
  final int sr;
  final int dfsId;
  final int bitrate;
  final int playTime;
  final int volumeDelta;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'size': size,
    'extension': extension,
    'sr': sr,
    'dfsId': dfsId,
    'bitrate': bitrate,
    'playTime': playTime,
    'volumeDelta': volumeDelta,
  };
}