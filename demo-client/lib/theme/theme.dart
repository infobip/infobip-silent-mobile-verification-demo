import 'package:flutter/material.dart';

class IdentityDemoTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.deepOrange,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 13, color: Colors.black),
        labelMedium: TextStyle(fontSize: 23, color: Colors.black),
      ),
    );
  }
}
