import 'package:ecommerce/utils/theme/color_schema.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorSchema,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.green), // 👈 input text color
    ),
    iconTheme: IconThemeData(color: Colors.black),
    tabBarTheme: TabBarThemeData(indicatorColor: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    ),
  );

  // darkthem colors
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorSchema,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    tabBarTheme: TabBarThemeData(indicatorColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      labelStyle: TextStyle(color: Colors.white),
    ),
  );
}
