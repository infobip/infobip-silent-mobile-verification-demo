part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class DebugChanged extends AppEvent {
  const DebugChanged(this.debug);

  final bool debug;
}
