import 'package:infobip_mi_demo_app/api/models/verify_api_response.dart';

class SMVSuccess {
  final SMVResult result;
  final String token;
  final String msisdn;
  final String? deviceIp;
  final int? devicePort;

  SMVSuccess(
    this.result,
    this.token,
    this.msisdn,
    this.deviceIp,
    this.devicePort,
  );
}
