class CacheException implements Exception {}

class CustomException implements Exception {
  String message;
  Exception? exception;
  CustomException(this.message, [this.exception]);
}
