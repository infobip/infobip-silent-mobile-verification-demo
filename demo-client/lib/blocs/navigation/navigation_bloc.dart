import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationStateHome()) {
    on<HomePageRequested>((event, emit) => emit(NavigationStateHome()));
    on<SmvPageRequested>((event, emit) => emit(NavigationStateSmv()));
    on<SettingsPageRequested>((event, emit) => emit(NavigationStateSettings()));
  }
}
