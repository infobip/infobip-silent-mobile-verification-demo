import 'package:infobip_mi_demo_app/api/models/cellular_switch_result.dart';
import 'package:infobip_mi_demo_app/api/models/verify_api_response.dart';

class VerifyResult {
  final VerifyApiResponse? verifyApiResponse;
  final CellularSwitchResult cellularSwitchResult;

  VerifyResult(
      {this.verifyApiResponse,
      this.cellularSwitchResult = CellularSwitchResult.success});

  VerifyResult.fromJson(Map<String, dynamic> json)
      : cellularSwitchResult = CellularSwitchResult.fromName(json['result']),
        verifyApiResponse = json['verifyResponse'] == null
            ? null
            : VerifyApiResponse.fromJson(json['verifyResponse']);
}
