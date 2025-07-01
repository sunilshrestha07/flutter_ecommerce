import 'package:ecommerce/features/onboarding/controller/onboardingmain.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppState();
}

class _AppState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Onboardingmain();
  }
}
