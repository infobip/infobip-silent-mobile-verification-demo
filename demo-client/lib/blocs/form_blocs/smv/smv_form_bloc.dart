import 'dart:developer' as developer;

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:infobip_mi_demo_app/api/api_service.dart';
import 'package:infobip_mi_demo_app/api/models/cellular_switch_result.dart';
import 'package:infobip_mi_demo_app/api/models/device_address.dart';
import 'package:infobip_mi_demo_app/api/models/verify_exception.dart';
import 'package:infobip_mi_demo_app/api/models/verify_result.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_failure.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_success.dart';
import 'package:infobip_mi_demo_app/utils/validators.dart';

class SMVFormBloc extends FormBloc<SMVSuccess, SMVFailure> {
  final msisdn = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      (value) => MsisdnValidator.validateMobilePhone(value)
    ],
  );

  final bool debugEnabled;

  SMVFormBloc(this.debugEnabled) {
    addFieldBloc(fieldBloc: msisdn);
  }

  @override
  void onSubmitting() async {
    await sendVerifyRequest();
  }

  Future<void> sendVerifyRequest() async {
    DeviceAddress? deviceAddress;
    try {
      var client = ApiService();

      if (debugEnabled) {
        deviceAddress = await client.fetchDeviceAddress();
      }
      var result = await client.sendVerifyRequest(msisdn.value);

      _handleResult(result, deviceAddress);
    } on VerifyException catch (e) {
      developer.log('Error during verifying with exception: $e');
      emitFailure(
          failureResponse: SMVFailure(e.errorDescription, msisdn.value,
              token: e.token,
              deviceIp: deviceAddress?.address,
              devicePort: deviceAddress?.port));
    } catch (e) {
      developer.log('Error during verifying with exception: $e');
      emitFailure(
          failureResponse: SMVFailure('Something went wrong', msisdn.value,
              deviceIp: deviceAddress?.address,
              devicePort: deviceAddress?.port));
    }
  }

  void _handleResult(VerifyResult verifyResult, DeviceAddress? deviceAddress) {
    if (verifyResult.cellularSwitchResult != CellularSwitchResult.success) {
      emitFailure(
          failureResponse: SMVFailure(
              CellularSwitchResult.description(
                  verifyResult.cellularSwitchResult),
              msisdn.value));
    } else if (verifyResult.verifyApiResponse!.errorDescription != null) {
      emitFailure(
          failureResponse: SMVFailure(
              verifyResult.verifyApiResponse!.errorDescription!, msisdn.value,
              token: verifyResult.verifyApiResponse!.token,
              deviceIp: deviceAddress?.address,
              devicePort: deviceAddress?.port));
    } else {
      emitSuccess(
          successResponse: SMVSuccess(
              verifyResult.verifyApiResponse!.result!,
              verifyResult.verifyApiResponse!.token!,
              msisdn.value,
              deviceAddress?.address,
              deviceAddress?.port));
    }
  }
}
