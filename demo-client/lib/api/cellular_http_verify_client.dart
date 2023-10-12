import 'package:infobip_mi_demo_app/api/models/verify_result.dart';

abstract class CellularHttpVerifyClient {
  Future<VerifyResult> sendVerifyRequest(String msisdn);
}
