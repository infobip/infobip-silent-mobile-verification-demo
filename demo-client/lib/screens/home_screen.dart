import 'package:flutter/material.dart';
import 'package:infobip_mi_demo_app/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HamburgerAppBar(context: context, title: 'Home'),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 17,
          ),
          Padding(
              padding: const EdgeInsets.all(17),
              child: Text(
                'Welcome',
                style: Theme.of(context).textTheme.labelMedium,
              ))
        ],
      ),
    );
  }
}
