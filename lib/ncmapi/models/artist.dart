import 'safe_convert.dart';

class Artist {
  Artist({
    this.name = '',
    this.id = 0,
    this.picId = 0,
    this.img1v1Id = 0,
    this.briefDesc = '',
    this.picUrl = '',
    this.img1v1Url = '',
    this.albumSize = 0,
    required this.alias,
    this.trans = '',
    this.musicSize = 0,
    this.topicPerson = 0,
  });

  factory Artist.fromJson(Map<String, dynamic>? json) => Artist(
    name: asString(json, 'name'),
    id: asInt(json, 'id'),
    picId: asInt(json, 'picId'),
    img1v1Id: asInt(json, 'img1v1Id'),
    briefDesc: asString(json, 'briefDesc'),
    picUrl: asString(json, 'picUrl'),
    img1v1Url: asString(json, 'img1v1Url'),
    albumSize: asInt(json, 'albumSize'),
    alias: asList(json, 'alias').cast(),
    trans: asString(json, 'trans'),
    musicSize: asInt(json, 'musicSize'),
    topicPerson: asInt(json, 'topicPerson'),
  );

  final String name;
  final int id;
  final int picId;
  final int img1v1Id;
  final String briefDesc;
  final String picUrl;
  final String img1v1Url;
  final int albumSize;
  final List<String> alias;
  final String trans;
  final int musicSize;
  final int topicPerson;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'picId': picId,
    'img1v1Id': img1v1Id,
    'briefDesc': briefDesc,
    'picUrl': picUrl,
    'img1v1Url': img1v1Url,
    'albumSize': albumSize,
    'alias': alias.map((e) => e),
    'trans': trans,
    'musicSize': musicSize,
    'topicPerson': topicPerson,
  };
}