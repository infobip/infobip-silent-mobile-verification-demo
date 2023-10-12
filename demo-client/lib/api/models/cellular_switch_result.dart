enum CellularSwitchResult {
  success,
  cellularUnavailable,
  failNetworkReset,
  unknownError;

  static CellularSwitchResult fromName(String? name) {
    switch (name) {
      case 'SUCCESS':
        return CellularSwitchResult.success;
      case 'CELLULAR_UNAVAILABLE':
        return CellularSwitchResult.cellularUnavailable;
      case 'FAIL_NETWORK_RESET':
        return CellularSwitchResult.failNetworkReset;
      default:
        return CellularSwitchResult.unknownError;
    }
  }

  static String description(CellularSwitchResult result) {
    switch (result) {
      case cellularUnavailable:
        return 'Mobile Internet needs to be turned on.';
      case failNetworkReset:
        return 'Failed to reset to the default network.';
      case unknownError:
        return 'Unable to switch to Mobile Internet.';
      default:
        throw Error();
    }
  }
}
