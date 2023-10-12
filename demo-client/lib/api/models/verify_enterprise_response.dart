class VerifyEnterpriseResponse {
  final String? token;
  final String? deviceRedirectUrl;
  final String? errorDescription;

  VerifyEnterpriseResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        deviceRedirectUrl = json['deviceRedirectUrl'],
        errorDescription = json['errorDescription'];
}