class MsisdnValidator {
  static String invalidFormat = 'Invalid msisdn format';

  static String? validateMobilePhone(String? value) {
    RegExp exp = RegExp(r'^[1-9][0-9]{10,14}$');
    return exp.hasMatch(value!) ? null : invalidFormat;
  }
}
