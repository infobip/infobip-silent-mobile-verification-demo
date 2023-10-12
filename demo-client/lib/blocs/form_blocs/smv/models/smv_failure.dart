class SMVFailure {
  final String errorDescription;
  final String msisdn;
  final String? token;
  final String? deviceIp;
  final int? devicePort;

  SMVFailure(
    this.errorDescription,
    this.msisdn, {
    this.token,
    this.deviceIp,
    this.devicePort,
  });
}
