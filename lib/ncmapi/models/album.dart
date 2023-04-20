import 'safe_convert.dart';
import 'artist.dart';

class Album {
  Album({
    this.name = '',
    this.id = 0,
    this.type = '',
    this.size = 0,
    this.picId = 0,
    this.blurPicUrl = '',
    this.companyId = 0,
    this.pic = 0,
    this.picUrl = '',
    this.publishTime = 0,
    this.description = '',
    this.tags = '',
    this.company = '',
    this.briefDesc = '',
    required this.artist,
    required this.songs,
    required this.alias,
    this.status = 0,
    this.copyrightId = 0,
    this.commentThreadId = '',
    required this.artists,
    this.subType = '',
    this.transName,
    this.onSale = false,
    this.mark = 0,
    this.picIdStr = '',
  });

  factory Album.fromJson(Map<String, dynamic>? json) => Album(
    name: asString(json, 'name'),
    id: asInt(json, 'id'),
    type: asString(json, 'type'),
    size: asInt(json, 'size'),
    picId: asInt(json, 'picId'),
    blurPicUrl: asString(json, 'blurPicUrl'),
    companyId: asInt(json, 'companyId'),
    pic: asInt(json, 'pic'),
    picUrl: asString(json, 'picUrl'),
    publishTime: asInt(json, 'publishTime'),
    description: asString(json, 'description'),
    tags: asString(json, 'tags'),
    company: asString(json, 'company'),
    briefDesc: asString(json, 'briefDesc'),
    artist: Artist.fromJson(asMap(json, 'artist')),
    songs: asList(json, 'songs'),
    alias: asList(json, 'alias'),
    status: asInt(json, 'status'),
    copyrightId: asInt(json, 'copyrightId'),
    commentThreadId: asString(json, 'commentThreadId'),
    artists:
    asList(json, 'artists').map((e) => Artist.fromJson(e)).toList(),
    subType: asString(json, 'subType'),
    transName: asString(json, 'transName'),
    onSale: asBool(json, 'onSale'),
    mark: asInt(json, 'mark'),
    picIdStr: asString(json, 'picId_str'),
  );

  final String name;
  final int id;
  final String type;
  final int size;
  final int picId;
  final String blurPicUrl;
  final int companyId;
  final int pic;
  final String picUrl;
  final int publishTime;
  final String description;
  final String tags;
  final String company;
  final String briefDesc;
  final Artist artist;
  final List<dynamic> songs;
  final List<dynamic> alias;
  final int status;
  final int copyrightId;
  final String commentThreadId;
  final List<Artist> artists;
  final String subType;
  final dynamic transName;
  final bool onSale;
  final int mark;
  final String picIdStr;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'type': type,
    'size': size,
    'picId': picId,
    'blurPicUrl': blurPicUrl,
    'companyId': companyId,
    'pic': pic,
    'picUrl': picUrl,
    'publishTime': publishTime,
    'description': description,
    'tags': tags,
    'company': company,
    'briefDesc': briefDesc,
    'artist': artist.toJson(),
    'songs': songs.map((e) => e),
    'alias': alias.map((e) => e),
    'status': status,
    'copyrightId': copyrightId,
    'commentThreadId': commentThreadId,
    'artists': artists.map((e) => e.toJson()),
    'subType': subType,
    'transName': transName,
    'onSale': onSale,
    'mark': mark,
    'picId_str': picIdStr,
  };
}