import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'DB Heavent',
    primaryColor: Colors.purple,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 20),
      titleMedium: TextStyle(fontSize: 20),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      titleTextStyle: const TextStyle(
        color: Colors.purple,
        fontFamily: 'DB Heavent',
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
