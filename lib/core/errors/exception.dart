class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException({this.message = '', this.statusCode = 0});
}

class CacheException implements Exception {
  final String message;
  final int statusCode;

  CacheException({this.message = '', this.statusCode = 0});
}
