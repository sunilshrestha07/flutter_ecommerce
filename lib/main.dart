import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:ecommerce/features/onboarding/controller/onboardingmain.dart';
import 'package:ecommerce/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // home: Onboardingmain(),
      home: Homepage(),
    );
  }
}
