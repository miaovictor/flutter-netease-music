import 'safe_convert.dart';

class PersonalizedPlaylist {
  PersonalizedPlaylist({
    this.hasTaste = false,
    this.code = 0,
    this.category = 0,
    required this.result,
  });

  factory PersonalizedPlaylist.fromJson(Map<String, dynamic>? json) => PersonalizedPlaylist(
    hasTaste: asBool(json, 'hasTaste'),
    code: asInt(json, 'code'),
    category: asInt(json, 'category'),
    result: asList(json, 'result')
        .map((e) => PersonalizedPlaylistItem.fromJson(e))
        .toList(),
  );
  final bool hasTaste;
  final int code;
  final int category;
  final List<PersonalizedPlaylistItem> result;

  Map<String, dynamic> toJson() => {
    'hasTaste': hasTaste,
    'code': code,
    'category': category,
    'result': result.map((e) => e.toJson()),
  };
}

class PersonalizedPlaylistItem {
  PersonalizedPlaylistItem({
    this.id = 0,
    this.type = 0,
    this.name = '',
    this.copywriter = '',
    this.picUrl = '',
    this.canDislike = false,
    this.trackNumberUpdateTime = 0,
    this.playCount = 0,
    this.trackCount = 0,
    this.highQuality = false,
    this.alg = '',
  });

  factory PersonalizedPlaylistItem.fromJson(Map<String, dynamic>? json) =>
      PersonalizedPlaylistItem(
        id: asInt(json, 'id'),
        type: asInt(json, 'type'),
        name: asString(json, 'name'),
        copywriter: asString(json, 'copywriter'),
        picUrl: asString(json, 'picUrl'),
        canDislike: asBool(json, 'canDislike'),
        trackNumberUpdateTime: asInt(json, 'trackNumberUpdateTime'),
        playCount: asInt(json, 'playCount'),
        trackCount: asInt(json, 'trackCount'),
        highQuality: asBool(json, 'highQuality'),
        alg: asString(json, 'alg'),
      );

  final int id;
  final int type;
  final String name;
  final String copywriter;
  final String picUrl;
  final bool canDislike;
  final int trackNumberUpdateTime;
  final int playCount;
  final int trackCount;
  final bool highQuality;
  final String alg;

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name': name,
    'copywriter': copywriter,
    'picUrl': picUrl,
    'canDislike': canDislike,
    'trackNumberUpdateTime': trackNumberUpdateTime,
    'playCount': playCount,
    'trackCount': trackCount,
    'highQuality': highQuality,
    'alg': alg,
  };
}
