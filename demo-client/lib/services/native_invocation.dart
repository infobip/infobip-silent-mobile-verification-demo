import 'package:flutter/services.dart';

enum MethodChannelName {
  network('infobip.mi.demo/network');

  final String name;

  const MethodChannelName(this.name);
}

Future<String?> switchToCellularNetwork() {
  MethodChannel platform = MethodChannel(MethodChannelName.network.name);
  return platform.invokeMethod<String>('switchToCellular');
}

Future<dynamic> sendRequestViaCellular(String msisdn, String host) {
  MethodChannel platform = MethodChannel(MethodChannelName.network.name);
  return platform
      .invokeMethod('sendRequestViaCellular', {'msisdn': msisdn, 'host': host});
}

Future<bool?> resetToDefaultNetwork() async {
  MethodChannel platform = MethodChannel(MethodChannelName.network.name);
  return await platform.invokeMethod<bool>('resetToDefaultNetwork');
}
