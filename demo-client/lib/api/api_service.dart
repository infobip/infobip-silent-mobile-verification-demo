import 'dart:io' show HttpClient, Platform;

import 'package:infobip_mi_demo_app/api/cellular_http_verify_client.dart';
import 'package:infobip_mi_demo_app/api/http_verify_client_android.dart';
import 'package:infobip_mi_demo_app/api/models/device_address.dart';
import 'package:infobip_mi_demo_app/api/models/verify_result.dart';
import 'package:infobip_mi_demo_app/utils/json_converter.dart';

import '../config/app_config.dart';

class ApiService {
  Future<VerifyResult> sendVerifyRequest(String msisdn) async {
    var cellularHttpClient = resolveHttpClient();
    return cellularHttpClient.sendVerifyRequest(msisdn);
  }

  Future<DeviceAddress> fetchDeviceAddress() async {
    final client = HttpClient()
      ..connectionTimeout = AppConfiguration.requestTimeout;

    final enterpriseRequest = await client.getUrl(
        Uri.parse('${AppConfiguration.backendApiBaseUrl}/device-address'));

    final response = await enterpriseRequest
        .close()
        .timeout(AppConfiguration.requestTimeout);

    return DeviceAddress.fromJson(await toJson(response));
  }

  CellularHttpVerifyClient resolveHttpClient() {
    if (Platform.isAndroid) return AndroidHttpVerifyClient();
    throw Exception("Unsupported platform");
  }
}
