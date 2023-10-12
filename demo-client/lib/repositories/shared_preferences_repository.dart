import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesKey { debug }

class SharedPreferencesRepository {
  static SharedPreferencesRepository? _instance;
  final _debugController = StreamController<bool?>();

  static SharedPreferencesRepository instance() {
    _instance ??= SharedPreferencesRepository();
    return _instance!;
  }

  static getValue(SharedPreferencesKey key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? stringValue = preferences.getString(key.name);
    return stringValue;
  }

  static setValue(SharedPreferencesKey key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key.name, value);
  }

  Stream<bool?> get debug async* {
    final debug = await getValue(SharedPreferencesKey.debug) as String?;
    yield debug == null
        ? null
        : debug == 'true'
            ? true
            : false;
    yield* _debugController.stream;
  }

  void saveDebug(bool debug) {
    setValue(SharedPreferencesKey.debug, debug.toString());
    _debugController.add(debug);
  }
}
