import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _baseUrl = 'http://localhost:8080/api';
// const _auth =
//     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMkB0ZXN0LmNvbSIsImlzcyI6Ik1JVSIsImlhdCI6MTY5OTA3MjUyNywiZXhwIjoxNjk5NDMyNTI3LCJyb2xlIjoiVVNFUiJ9.3SC50ePLfuK_Wl4r-k2LIbHRcbMgjQaMg9Ty0jIgM9jefXEf_UZXjcBLBNK0lnADPfHPKweb1KPVfaaihrQ2Yg';
const _auth =
    'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMTBAdGVzdC5jb20iLCJpc3MiOiJNSVUiLCJpYXQiOjE3MDMzMTA0MzUsImV4cCI6MTcwMzY3MDQzNSwicm9sZSI6IlVTRVIifQ.m-5OtPUNi41aw55CTZfdtMTqKa0nWIqqQj1RJKfVp9y0D1tF27Cy4SaUD6OMpm-WksssjbIcDaxB-maq59epXQ';

const _header = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': _auth,
};

class NetworkAPI {
  NetworkAPI({required this.endpoint, this.baseUrl = _baseUrl});
  String endpoint;
  String baseUrl;

  ///params should be 'param1=abc&param2=abc' or null
  Future<Response> getAll({String? params}) async {
    var uri = Uri.parse('$baseUrl$endpoint?$params');
    return await http.get(uri, headers: _header);
  }

  Future<Response> getById(id) async {
    var uri = Uri.parse('$baseUrl$endpoint/$id');
    return await http.get(uri, headers: _header);
  }

  Future<Response> add(String data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.post(uri, body: data, headers: _header);
  }

  Future<Response> update(id, String data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.put(uri, body: data, headers: _header);
  }

  Future<Response> remove(id) async {
    var uri = Uri.parse('$baseUrl$endpoint/$id');
    return http.delete(uri, headers: _header);
  }
}
