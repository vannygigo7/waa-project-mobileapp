import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _baseUrl = 'http://localhost:8080/api';
const _auth =
    'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMkB0ZXN0LmNvbSIsImlzcyI6Ik1JVSIsImlhdCI6MTY5OTA0NDAzMCwiZXhwIjoxNjk5NDA0MDMwLCJyb2xlIjoiVVNFUiJ9.VUSJonsdHH--iR4dDDQjkv4OfjTOTRYG-ToCEQJHMUGZBzJPJOKjhUeMbnv4ccn7b839azhgdS0twtAxCtiPMw';
const _header = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': _auth,
};

class NetworkAPI {
  NetworkAPI({required this.endpoint, this.baseUrl = _baseUrl});
  String endpoint;
  String baseUrl;

  Future<Response> getAll() async {
    var uri = Uri.parse('$baseUrl$endpoint');
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
