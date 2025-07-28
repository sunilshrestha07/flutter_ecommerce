import 'package:ecommerce/app_home.dart';
import 'package:ecommerce/common/hiveobject/cart_item_model.dart';
import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/services/notification_service.dart';
import 'package:ecommerce/utils/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> _backgroundMessaging(RemoteMessage message) async {}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Supabase.initialize(
      url: "https://fjxefyalmgsjpnshzver.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqeGVmeWFsbWdzanBuc2h6dmVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM0NDEzMTMsImV4cCI6MjA2OTAxNzMxM30.TAfROyyBjEzz4NjJrw3AREylJpOtAR431pOqZ3f3H3c",
    );
    FirebaseMessaging.onBackgroundMessage(_backgroundMessaging);
    await NotificationService().initNotification();

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
  } catch (e, st) {
    debugPrint("$e  $st");
  }
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
        // home: Scaffold(body: Center(child: Text("Release Build Works!"))),
      ),
    );
  }
}
