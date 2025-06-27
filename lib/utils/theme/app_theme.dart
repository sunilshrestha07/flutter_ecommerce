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
      displayMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    tabBarTheme: TabBarThemeData(indicatorColor: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(primary: const Color.fromARGB(255, 243, 95, 84)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      selectedItemColor: Colors.red[400],
    ),
  );

  // darkthem colors
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorSchema,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
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
      outlineBorder: BorderSide(color: Colors.white),
      activeIndicatorBorder: BorderSide(color: Colors.white),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 227, 110, 101)),
      ),
      labelStyle: TextStyle(color: Colors.white),
    ),
  );
}
