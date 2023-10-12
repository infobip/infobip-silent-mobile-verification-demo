import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/navigation/navigation_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Drawer(
        child: Column(
          children: [
            buildHeader(context),
            Expanded(child: buildMenuItems(context)),
          ],
        ),
      ));

  Container buildHeader(BuildContext context) => Container(
      padding: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset("assets/images/logo.png", width: 36),
          ),
          Text("Identity Demo",
              style: Theme.of(context).textTheme.headlineSmall)
        ],
      ));

  BlocBuilder buildMenuItems(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, navigationState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                ListTile(
                  selected: navigationState is NavigationStateHome,
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                  onTap: () =>
                      context.read<NavigationBloc>().add(HomePageRequested()),
                ),
                Theme(
                    data: theme.copyWith(
                      unselectedWidgetColor: Colors.black,
                      colorScheme:
                          theme.colorScheme.copyWith(secondary: Colors.black),
                    ),
                    child: ExpansionTile(
                      title: const Text('Demo'),
                      leading: const Icon(Icons.widgets_outlined),
                      childrenPadding: const EdgeInsets.only(left: 20),
                      collapsedIconColor: navigationState is NavigationStateSmv
                          ? theme.primaryColor
                          : null,
                      collapsedTextColor: navigationState is NavigationStateSmv
                          ? theme.primaryColor
                          : null,
                      initiallyExpanded: navigationState is NavigationStateSmv,
                      children: [
                        ListTile(
                          selected: navigationState is NavigationStateSmv,
                          leading: const Icon(Icons.mobile_friendly_outlined),
                          title: const Text('Silent Mobile Verification'),
                          onTap: () => context
                              .read<NavigationBloc>()
                              .add(SmvPageRequested()),
                        ),
                      ],
                    )),
                ListTile(
                  selected: navigationState is NavigationStateSettings,
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () => context
                      .read<NavigationBloc>()
                      .add(SettingsPageRequested()),
                ),
              ])),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: const Text('Powered by')),
                Image.asset('assets/images/logo.png', width: 24, height: 24),
              ],
            ),
          )
        ],
      );
    });
  }
}

class HamburgerAppBar extends AppBar {
  HamburgerAppBar({super.key, required BuildContext context, String? title})
      : super(
            title: title != null ? Text(title) : null,
            backgroundColor: Theme.of(context).primaryColor,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 36, // Changing Drawer Icon Size
                  ),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ));
}
