import 'dart:convert';
import 'dart:io';
import 'dart:math';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _apikey = 'cf6bb55f084ae24839ff33de49b8fe34';

  Future<String> getOTP() async {
    final code = 1000 + Random().nextInt(9000);
    await Future.delayed(const Duration(seconds: 1));
    return code.toString();
  }

  Future<bool> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
        username: username, password: password, requestToken: token);

    if (validToken['success'] as bool) {
      final json = await _makeSession(
          requestToken: validToken['request_token'] as String);
      return json['success'] as bool;
    } else {
      return validToken['success'] as bool;
    }
  }

  Uri _makeUri(String path, [Map<String, dynamic>? param]) {
    final uri = Uri.parse('$_host$path');
    if (param != null) {
      return uri.replace(queryParameters: param);
    } else {
      return uri;
    }
  }

  Future<String> _makeToken() async {
    final url = _makeUri('/authentication/token/new', {'api_key': _apikey});

    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final token = json['request_token'] as String;
    return token;
  }

  Future<Map<String, dynamic>> _validateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    final url = _makeUri(
        '/authentication/token/validate_with_login', {'api_key': _apikey});

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    // final token = json['request_token'] as String;
    return json;
  }

  Future<Map<String, dynamic>> _makeSession(
      {required String requestToken}) async {
    final url = _makeUri('/authentication/session/new', {'api_key': _apikey});

    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));

    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    // final sessionId = json['session_id'] as String;
    return json;
  }
}
