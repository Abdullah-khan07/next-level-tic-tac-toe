import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}