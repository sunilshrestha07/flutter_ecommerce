import 'package:ecommerce/app_home.dart';
import 'package:ecommerce/common/hiveobject/cart_item_model.dart';
import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // find the path of the app
  final dir = await path.getApplicationDocumentsDirectory();
  // initialize the hive
  await Hive.initFlutter(dir.path);
  // register the adapter for the cartitem
  Hive.registerAdapter<CartItemModel>(CartItemAdapter());
  Hive.registerAdapter<UserModel>(UserModelAdapter());

  // create boxes of hive
  await Hive.openBox("userHiveBox");
  await Hive.openBox<CartItemModel>("cartItemBox");
  await Hive.openBox<UserModel>("userDetailsHiveBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ItemProvider())],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: AppHome(),
        // home: Homepage(),
      ),
    );
  }
}
