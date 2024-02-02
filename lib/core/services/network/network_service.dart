import 'dart:io';

import 'package:auction_app/core/services/auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _baseUrl = 'http://localhost:8080/api';

const _headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  // HttpHeaders.authorizationHeader:
  //     'bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjdXN0b21lcjEwQHRlc3QuY29tIiwiaXNzIjoiTUlVIiwiaWF0IjoxNzA0MDgxMzk1LCJleHAiOjE3MDQ0NDEzOTUsInJvbGUiOiJVU0VSIn0.LUicGuhdOvGEIRz5M55ZrkBdC6GgTZQwfD57VyMROYZEdTR6_3UkOBQ7OwMCfdonyIZUd3LwLwZ55w1-of40Kw'
};

class NetworkService {
  NetworkService({required this.endpoint, this.baseUrl = _baseUrl});

  String endpoint;
  final String baseUrl;

  Map<String, String>? get headers {
    if (AuthManager.instance.accessToken != null) {
      return {
        ..._headers,
        HttpHeaders.authorizationHeader:
            'bearer ${AuthManager.instance.accessToken!}'
      };
    }
    return _headers;
  }

  _getUri({String suffix = ''}) {
    return Uri.parse('$baseUrl$endpoint$suffix');
  }

  ///params should be 'param1=abc&param2=abc' or null
  Future<Response> getAll({String? params}) async {
    var uri = _getUri(suffix: params == null ? '' : '?$params');
    return await http.get(uri, headers: headers);
  }

  Future<Response> getById(id) async {
    var uri = _getUri(suffix: '/$id');
    return await http.get(uri, headers: headers);
  }

  Future<Response> post(String data) async {
    var uri = _getUri();
    return await http.post(uri, body: data, headers: headers);
  }

  Future<Response> update(id, String data) async {
    var uri = _getUri();
    return await http.put(uri, body: data, headers: headers);
  }

  Future<Response> delete(id) async {
    var uri = _getUri(suffix: '/$id');
    return http.delete(uri, headers: headers);
  }
}
