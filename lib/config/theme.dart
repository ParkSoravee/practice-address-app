import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    // fontFamily:
    primaryColor: Colors.purple,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      titleTextStyle: const TextStyle(color: Colors.purple),
    ),
  );
}
