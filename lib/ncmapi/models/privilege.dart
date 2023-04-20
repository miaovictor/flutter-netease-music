import 'safe_convert.dart';

class Privilege {
  Privilege({
    this.id = 0,
    this.fee = 0,
    this.payed = 0,
    this.st = 0,
    this.pl = 0,
    this.dl = 0,
    this.sp = 0,
    this.cp = 0,
    this.subp = 0,
    this.cs = false,
    this.maxbr = 0,
    this.fl = 0,
    this.toast = false,
    this.flag = 0,
    this.preSell = false,
    this.playMaxbr = 0,
    this.downloadMaxbr = 0,
    this.rscl,
    required this.freeTrialPrivilege,
    required this.chargeInfoList,
  });

  factory Privilege.fromJson(Map<String, dynamic>? json) => Privilege(
    id: asInt(json, 'id'),
    fee: asInt(json, 'fee'),
    payed: asInt(json, 'payed'),
    st: asInt(json, 'st'),
    pl: asInt(json, 'pl'),
    dl: asInt(json, 'dl'),
    sp: asInt(json, 'sp'),
    cp: asInt(json, 'cp'),
    subp: asInt(json, 'subp'),
    cs: asBool(json, 'cs'),
    maxbr: asInt(json, 'maxbr'),
    fl: asInt(json, 'fl'),
    toast: asBool(json, 'toast'),
    flag: asInt(json, 'flag'),
    preSell: asBool(json, 'preSell'),
    playMaxbr: asInt(json, 'playMaxbr'),
    downloadMaxbr: asInt(json, 'downloadMaxbr'),
    rscl: asString(json, 'rscl'),
    freeTrialPrivilege:
    FreeTrialPrivilege.fromJson(asMap(json, 'freeTrialPrivilege')),
    chargeInfoList: asList(json, 'chargeInfoList')
        .map((e) => ChargeInfoListItem.fromJson(e))
        .toList(),
  );
  final int id;
  final int fee;
  final int payed;
  final int st;
  final int pl;
  final int dl;
  final int sp;
  final int cp;
  final int subp;
  final bool cs;
  final int maxbr;
  final int fl;
  final bool toast;
  final int flag;
  final bool preSell;
  final int playMaxbr;
  final int downloadMaxbr;
  final dynamic rscl;
  final FreeTrialPrivilege freeTrialPrivilege;
  final List<ChargeInfoListItem> chargeInfoList;

  Map<String, dynamic> toJson() => {
    'id': id,
    'fee': fee,
    'payed': payed,
    'st': st,
    'pl': pl,
    'dl': dl,
    'sp': sp,
    'cp': cp,
    'subp': subp,
    'cs': cs,
    'maxbr': maxbr,
    'fl': fl,
    'toast': toast,
    'flag': flag,
    'preSell': preSell,
    'playMaxbr': playMaxbr,
    'downloadMaxbr': downloadMaxbr,
    'rscl': rscl,
    'freeTrialPrivilege': freeTrialPrivilege.toJson(),
    'chargeInfoList': chargeInfoList.map((e) => e.toJson()),
  };
}

class FreeTrialPrivilege {
  FreeTrialPrivilege({
    this.resConsumable = false,
    this.userConsumable = false,
  });

  factory FreeTrialPrivilege.fromJson(Map<String, dynamic>? json) =>
      FreeTrialPrivilege(
        resConsumable: asBool(json, 'resConsumable'),
        userConsumable: asBool(json, 'userConsumable'),
      );
  final bool resConsumable;
  final bool userConsumable;

  Map<String, dynamic> toJson() => {
    'resConsumable': resConsumable,
    'userConsumable': userConsumable,
  };
}

class ChargeInfoListItem {
  ChargeInfoListItem({
    this.rate = 0,
    this.chargeType = 0,
  });

  factory ChargeInfoListItem.fromJson(Map<String, dynamic>? json) =>
      ChargeInfoListItem(
        rate: asInt(json, 'rate'),
        chargeType: asInt(json, 'chargeType'),
      );
  final int rate;
  final int chargeType;

  Map<String, dynamic> toJson() => {
    'rate': rate,
    'chargeType': chargeType,
  };
}