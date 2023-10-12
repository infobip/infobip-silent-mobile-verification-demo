part of 'app_bloc.dart';

class AppState {
  AppState(this.debug);

  final bool debug;

  AppState copyWith({bool? debug}) {
    return AppState(debug ?? this.debug);
  }
}
