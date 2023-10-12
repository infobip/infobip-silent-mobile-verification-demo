import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/app/app_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/navigation/navigation_bloc.dart';
import 'package:infobip_mi_demo_app/screens/home_screen.dart';
import 'package:infobip_mi_demo_app/screens/settings_screen.dart';
import 'package:infobip_mi_demo_app/screens/smv_screen.dart';
import 'package:infobip_mi_demo_app/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const appTitle = 'Mobile Identity Demo';

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NavigationBloc()),
          BlocProvider(create: (_) => AppBloc()),
        ],
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return MaterialApp(
            title: appTitle,
            theme: IdentityDemoTheme.light,
            home: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (_, state) {
                if (state is NavigationStateSettings) {
                  return const SettingsScreen();
                } else if (state is NavigationStateSmv) {
                  return const SMVScreen();
                } else {
                  return const HomeScreen();
                }
              },
            ),
          );
        }),
      );
}
