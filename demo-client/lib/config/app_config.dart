abstract class AppConfiguration {
  static const String backendApiBaseUrl = 'http://10.0.2.2:8080';
  static const Duration requestTimeout = Duration(seconds: 10);
  static const int pollingRetryLimit = 3;
  static const Duration pollingRetryInterval = Duration(seconds: 2);
}
