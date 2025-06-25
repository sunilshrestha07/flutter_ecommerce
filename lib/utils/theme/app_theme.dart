import 'package:ecommerce/utils/theme/color_schema.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorSchema,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
    ),
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorSchema,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ),
  );
}
