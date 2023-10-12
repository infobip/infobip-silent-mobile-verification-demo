enum SMVResult {
  valid,
  invalid,
  error;

  static SMVResult _fromString(String smvResult) {
    return SMVResult.values
        .firstWhere((element) => element.name.toUpperCase() == smvResult);
  }
}

class VerifyApiResponse {
  final String? errorDescription;
  final String? token;
  final SMVResult? result;

  VerifyApiResponse.fromJson(Map<String, dynamic> json)
      : errorDescription = json['errorDescription'],
        token = json['token'],
        result = json['result'] != null
            ? SMVResult._fromString(json['result'])
            : null;
}
