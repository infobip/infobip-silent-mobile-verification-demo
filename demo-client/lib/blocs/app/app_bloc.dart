import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:infobip_mi_demo_app/repositories/shared_preferences_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(false)) {
    on<DebugChanged>(_onDebugChanged);
    _subscribeToRepository();
  }

  final SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferencesRepository.instance();
  late StreamSubscription<bool?> _debugSubscription;

  void _onDebugChanged(
    DebugChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(debug: event.debug));
  }

  void _subscribeToRepository() {
    _debugSubscription = sharedPreferencesRepository.debug.listen((debug) {
      if (debug != null) {
        add(DebugChanged(debug));
      } else {
        sharedPreferencesRepository.saveDebug(false);
      }
    });
  }

  @override
  Future<void> close() {
    _debugSubscription.cancel();
    return super.close();
  }
}
