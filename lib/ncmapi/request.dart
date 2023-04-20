import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:quiet/ncmapi/crypto.dart';

typedef DebugPrinter = void Function(String message);

DebugPrinter debugPrint = (msg) {
  print(msg);
};

enum Crypto { linuxapi, weapi, eapi }

class Response {
  final int status;
  final Map body;
  final List<Cookie> cookie;

  const Response(
      {this.status = 500,
      this.body = const {'code': 500, 'msg': 'server error'},
      this.cookie = const []});

  Response copy({int? status, Map? body, List? cookie}) {
    return Response(
        status: status ?? this.status,
        body: body ?? this.body,
        cookie: cookie as List<Cookie>? ?? this.cookie);
  }
}

class RequestError implements Exception {
  RequestError({
    required this.code,
    required this.message,
    required this.response,
  });

  final int code;
  final String message;
  final Response response;

  @override
  String toString() => 'RequestError: $code - $message';
}

Future<Response> request(
  String method,
  String url,
  Map data, {
  List<Cookie> cookies = const [],
  String? ua,
  Crypto crypto = Crypto.weapi,
}) async {
  data = Map.from(data);
  final headers = _buildHeader(url, ua, method, cookies);
  if (crypto == Crypto.weapi) {
    var csrfToken = cookies.firstWhereOrNull((c) => c.name == "__csrf");
    data["csrf_token"] = csrfToken?.value ?? "";
    data = weApi(data);
    url = url.replaceAll(RegExp(r"\w*api"), 'weapi');
  } else if (crypto == Crypto.linuxapi) {
    data = linuxApi({
      "params": data,
      "url": url.replaceAll(RegExp(r"\w*api"), 'api'),
      "method": method,
    });
    headers['User-Agent'] =
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36';
    url = 'https://music.163.com/api/linux/forward';
  }

  return _doRequest(url, headers, data, method).then((response) async {
    var rsp = Response(cookie: response.cookies);

    final content =
        await response.cast<List<int>>().transform(utf8.decoder).join();
    final body = json.decode(content);
    rsp = rsp.copy(
        status: int.tryParse(body['code'].toString()) ?? response.statusCode,
        body: body);

    rsp = rsp.copy(
        status: rsp.status > 100 && rsp.status < 600 ? rsp.status : 400);
    return rsp;
  }).catchError((e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
    return Response(status: 502, body: {'code': 502, 'msg': e.toString()});
  });
}

Future<HttpClientResponse> _doRequest(
    String url, Map<String, String> headers, Map data, String method) {
  return HttpClient().openUrl(method, Uri.parse(url)).then((request) {
    headers.forEach(request.headers.add);
    request.write(Uri(queryParameters: data.cast()).query);
    return request.close();
  });
}

Map<String, String> _buildHeader(
    String url, String? ua, String method, List<Cookie> cookies) {
  final headers = {'User-Agent': _chooseUserAgent(ua: ua)};
  if (method.toUpperCase() == 'POST') {
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
  }
  if (url.contains('music.163.com')) {
    headers['Referer'] = 'https://music.163.com';
  }
  headers['Cookie'] = cookies.join("; ");
  return headers;
}

String _chooseUserAgent({String? ua}) {
  const userAgentList = [
    'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1',
    'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
    'Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) Mobile/14F89;GameHelper',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1',
    'Mozilla/5.0 (iPad; CPU OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:46.0) Gecko/20100101 Firefox/46.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/13.10586'
  ];

  var r = Random();
  int index;
  if (ua == 'mobile') {
    index = (r.nextDouble() * 7).floor();
  } else if (ua == "pc") {
    index = (r.nextDouble() * 5).floor() + 8;
  } else {
    index = (r.nextDouble() * (userAgentList.length - 1)).floor();
  }
  return userAgentList[index];
}
