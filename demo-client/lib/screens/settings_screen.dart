import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/app/app_bloc.dart';
import 'package:infobip_mi_demo_app/widgets/app_drawer.dart';
import 'package:infobip_mi_demo_app/widgets/settings/debug_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static Page page() => const MaterialPage<void>(child: SettingsScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: HamburgerAppBar(context: context, title: 'Settings'),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(17),
              child: buildSettingsItems(context)),
        ),
      );

  BlocBuilder buildSettingsItems(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 17),
            Stack(
              children: [
                TextField(
                  controller: TextEditingController(
                    text: appState.debug ? 'Enabled' : 'Disabled',
                  ),
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Debug',
                    icon: Icon(Icons.code),
                  ),
                  readOnly: true,
                ),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => _showEditDebugDialog(context, appState),
                    behavior: HitTestBehavior.translucent,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Future<void> _showEditDebugDialog(
      BuildContext context, AppState appState) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => DebugDialog(appState.debug),
    );
  }
}
