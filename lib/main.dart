import 'package:ecommerce/common/hiveProvider/hiveprovider.dart';
import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:ecommerce/features/onboarding/controller/onboardingmain.dart';
import 'package:ecommerce/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox("itemsBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Hiveprovider())],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        // home: Onboardingmain(),
        home: Homepage(),
      ),
    );
  }
}
