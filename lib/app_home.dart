import 'dart:async';

import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:ecommerce/features/onboarding/controller/onboardingmain.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppState();
}

class _AppState extends State<AppHome> {
  final _userHive = Hive.box("userHiveBox");
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    isLoggedIn = _userHive.get("isLoggedIn", defaultValue: false);
    Timer(
      Duration(seconds: 2),
      // debugPrint("isLoggedIn: ${isLoggedIn.toString()}");
      () {
        if (isLoggedIn == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Onboardingmain()),
            (Route<dynamic> route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          "Fashion Fusion",
        ),
      ),
    );
  }
}
