class DeviceAddress {
  final String address;
  final int port;

  DeviceAddress.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        port = json['port'];
}