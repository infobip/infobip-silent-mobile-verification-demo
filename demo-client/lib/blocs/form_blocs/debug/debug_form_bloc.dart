import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:infobip_mi_demo_app/repositories/shared_preferences_repository.dart';

class DebugFormBloc extends FormBloc<bool, String> {
  late SelectFieldBloc debug;
  final _sharedRepository = SharedPreferencesRepository.instance();

  DebugFormBloc(bool debugValue) {
    debug = SelectFieldBloc(
      items: [true, false],
      initialValue: debugValue,
    );

    addFieldBloc(fieldBloc: debug);
  }

  @override
  FutureOr<void> onSubmitting() {
    try {
      _sharedRepository.saveDebug(debug.value);
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
