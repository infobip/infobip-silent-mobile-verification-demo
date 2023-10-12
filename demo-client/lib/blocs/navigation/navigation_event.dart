part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

class HomePageRequested extends NavigationEvent {}

class SmvPageRequested extends NavigationEvent {}

class SettingsPageRequested extends NavigationEvent {}
