class VerifyException implements Exception {
  final String errorDescription;
  final String? token;

  VerifyException(this.errorDescription, this.token);
}