class ServerException implements Exception {
  final String? message;

  const ServerException({this.message});

  @override 
  String toString() => message ?? 'Something went wrong on the server.';
}

class CacheException implements Exception {}

class NoEnumFieldFoundException implements Exception {
  final String message;

  const NoEnumFieldFoundException(this.message);

  @override
  String toString() => message;
}
