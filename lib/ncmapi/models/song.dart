import 'safe_convert.dart';
import 'artist.dart';
import 'album.dart';
import 'music_res.dart';
import 'privilege.dart';

class Song {
  Song({
    this.name = '',
    this.id = 0,
    this.position = 0,
    required this.alias,
    this.status = 0,
    this.fee = 0,
    this.copyrightId = 0,
    this.disc = '',
    this.no = 0,
    required this.artists,
    required this.album,
    this.starred = false,
    this.popularity = 0,
    this.score = 0,
    this.starredNum = 0,
    this.duration = 0,
    this.playedNum = 0,
    this.dayPlays = 0,
    this.hearTime = 0,
    this.ringtone = '',
    this.crbt,
    this.audition,
    this.copyFrom = '',
    this.commentThreadId = '',
    this.rtUrl,
    this.ftype = 0,
    required this.rtUrls,
    this.copyright = 0,
    this.transName,
    this.sign,
    this.mark = 0,
    this.originCoverType = 0,
    this.originSongSimpleData,
    this.single = 0,
    this.noCopyrightRcmd,
    required this.hMusic,
    required this.mMusic,
    required this.lMusic,
    required this.bMusic,
    required this.sqMusic,
    required this.hrMusic,
    this.mvid = 0,
    this.mp3Url,
    this.rtype = 0,
    this.rurl,
    required this.privilege,
    this.alg = '',
  });

  factory Song.fromJson(Map<String, dynamic>? json) => Song(
    name: asString(json, 'name'),
    id: asInt(json, 'id'),
    position: asInt(json, 'position'),
    alias: asList(json, 'alias').cast(),
    status: asInt(json, 'status'),
    fee: asInt(json, 'fee'),
    copyrightId: asInt(json, 'copyrightId'),
    disc: asString(json, 'disc'),
    no: asInt(json, 'no'),
    artists:
    asList(json, 'artists').map((e) => Artist.fromJson(e)).toList(),
    album: Album.fromJson(asMap(json, 'album')),
    starred: asBool(json, 'starred'),
    popularity: asInt(json, 'popularity'),
    score: asInt(json, 'score'),
    starredNum: asInt(json, 'starredNum'),
    duration: asInt(json, 'duration'),
    playedNum: asInt(json, 'playedNum'),
    dayPlays: asInt(json, 'dayPlays'),
    hearTime: asInt(json, 'hearTime'),
    ringtone: asString(json, 'ringtone'),
    crbt: asString(json, 'crbt'),
    audition: asString(json, 'audition'),
    copyFrom: asString(json, 'copyFrom'),
    commentThreadId: asString(json, 'commentThreadId'),
    rtUrl: asString(json, 'rtUrl'),
    ftype: asInt(json, 'ftype'),
    rtUrls: asList(json, 'rtUrls'),
    copyright: asInt(json, 'copyright'),
    transName: asString(json, 'transName'),
    sign: asString(json, 'sign'),
    mark: asInt(json, 'mark'),
    originCoverType: asInt(json, 'originCoverType'),
    originSongSimpleData: asString(json, 'originSongSimpleData'),
    single: asInt(json, 'single'),
    noCopyrightRcmd: asString(json, 'noCopyrightRcmd'),
    hMusic: MusicRes.fromJson(asMap(json, 'hMusic')),
    mMusic: MusicRes.fromJson(asMap(json, 'mMusic')),
    lMusic: MusicRes.fromJson(asMap(json, 'lMusic')),
    bMusic: MusicRes.fromJson(asMap(json, 'bMusic')),
    sqMusic: MusicRes.fromJson(asMap(json, 'sqMusic')),
    hrMusic: MusicRes.fromJson(asMap(json, 'hrMusic')),
    mvid: asInt(json, 'mvid'),
    mp3Url: asString(json, 'mp3Url'),
    rtype: asInt(json, 'rtype'),
    rurl: asString(json, 'rurl'),
    privilege: Privilege.fromJson(asMap(json, 'privilege')),
    alg: asString(json, 'alg'),
  );
  final String name;
  final int id;
  final int position;
  final List<String> alias;
  final int status;
  final int fee;
  final int copyrightId;
  final String disc;
  final int no;
  final List<Artist> artists;
  final Album album;
  final bool starred;
  final int popularity;
  final int score;
  final int starredNum;
  final int duration;
  final int playedNum;
  final int dayPlays;
  final int hearTime;
  final String ringtone;
  final dynamic crbt;
  final dynamic audition;
  final String copyFrom;
  final String commentThreadId;
  final dynamic rtUrl;
  final int ftype;
  final List<dynamic> rtUrls;
  final int copyright;
  final dynamic transName;
  final dynamic sign;
  final int mark;
  final int originCoverType;
  final dynamic originSongSimpleData;
  final int single;
  final dynamic noCopyrightRcmd;
  final MusicRes hMusic;
  final MusicRes mMusic;
  final MusicRes lMusic;
  final MusicRes bMusic;
  final MusicRes sqMusic;
  final MusicRes hrMusic;
  final int mvid;
  final dynamic mp3Url;
  final int rtype;
  final dynamic rurl;
  final Privilege privilege;
  final String alg;

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'position': position,
    'alias': alias.map((e) => e),
    'status': status,
    'fee': fee,
    'copyrightId': copyrightId,
    'disc': disc,
    'no': no,
    'artists': artists.map((e) => e.toJson()),
    'album': album.toJson(),
    'starred': starred,
    'popularity': popularity,
    'score': score,
    'starredNum': starredNum,
    'duration': duration,
    'playedNum': playedNum,
    'dayPlays': dayPlays,
    'hearTime': hearTime,
    'ringtone': ringtone,
    'crbt': crbt,
    'audition': audition,
    'copyFrom': copyFrom,
    'commentThreadId': commentThreadId,
    'rtUrl': rtUrl,
    'ftype': ftype,
    'rtUrls': rtUrls.map((e) => e),
    'copyright': copyright,
    'transName': transName,
    'sign': sign,
    'mark': mark,
    'originCoverType': originCoverType,
    'originSongSimpleData': originSongSimpleData,
    'single': single,
    'noCopyrightRcmd': noCopyrightRcmd,
    'hMusic': hMusic.toJson(),
    'mMusic': mMusic.toJson(),
    'lMusic': lMusic.toJson(),
    'bMusic': bMusic.toJson(),
    'mvid': mvid,
    'mp3Url': mp3Url,
    'rtype': rtype,
    'rurl': rurl,
    'privilege': privilege.toJson(),
    'alg': alg,
  };
}