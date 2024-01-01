import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _baseUrl = 'http://localhost:8080/api';
// const _auth =
//     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMkB0ZXN0LmNvbSIsImlzcyI6Ik1JVSIsImlhdCI6MTY5OTA3MjUyNywiZXhwIjoxNjk5NDMyNTI3LCJyb2xlIjoiVVNFUiJ9.3SC50ePLfuK_Wl4r-k2LIbHRcbMgjQaMg9Ty0jIgM9jefXEf_UZXjcBLBNK0lnADPfHPKweb1KPVfaaihrQ2Yg';

const _headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.authorizationHeader:
      'bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjdXN0b21lcjEwQHRlc3QuY29tIiwiaXNzIjoiTUlVIiwiaWF0IjoxNzA0MDgxMzk1LCJleHAiOjE3MDQ0NDEzOTUsInJvbGUiOiJVU0VSIn0.LUicGuhdOvGEIRz5M55ZrkBdC6GgTZQwfD57VyMROYZEdTR6_3UkOBQ7OwMCfdonyIZUd3LwLwZ55w1-of40Kw'
};

class NetworkService {
  NetworkService({required this.endpoint, this.baseUrl = _baseUrl}) {
    headers = _headers;
  }

  String endpoint;
  Map<String, String>? headers;
  final String baseUrl;

  ///params should be 'param1=abc&param2=abc' or null
  Future<Response> getAll({String? params}) async {
    var uri = Uri.parse('$baseUrl$endpoint?$params');
    return await http.get(uri, headers: headers);
  }

  Future<Response> getById(id) async {
    var uri = Uri.parse('$baseUrl$endpoint/$id');
    return await http.get(uri, headers: headers);
  }

  Future<Response> post(String data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.post(uri, body: data, headers: headers);
  }

  Future<Response> update(id, String data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.put(uri, body: data, headers: headers);
  }

  Future<Response> delete(id) async {
    var uri = Uri.parse('$baseUrl$endpoint/$id');
    return http.delete(uri, headers: headers);
  }
}
