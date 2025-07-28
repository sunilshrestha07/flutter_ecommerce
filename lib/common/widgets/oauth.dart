import 'dart:convert';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Oauth extends StatefulWidget {
  const Oauth({super.key});

  @override
  State<Oauth> createState() => _OauthState();
}

class _OauthState extends State<Oauth> {
  String email = "";
  final _userBox = Hive.box<UserModel>("userDetailsHiveBox");
  final _userHiveBox = Hive.box("userHiveBox");
  bool isNewUser = false;
  // Handle Google Sign-In
  Future<void> handleGoogleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      setState(() {
        email = googleUser!.email;
      });
      // Handle Google Sign-In cancel
      if (googleUser == null) {
        return;
      } else {
        final formdata = {
          "userName": googleUser.displayName,
          "avatar": googleUser.photoUrl,
          "email": googleUser.email,
          "password": googleUser.displayName,
        };
        try {
          final res = await http.post(
            Uri.parse("https://fashion-fusion-suneel.vercel.app/api/user/googlelogin"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(formdata),
          );
          if (res.statusCode == 200) {
            final data = jsonDecode(res.body);
            if (data.containsKey("user")) {
              final user = data['user'] as Map<String, dynamic>;
              setState(() {
                isNewUser = false;
              });
              final userDetails = UserModel.fromJson(user);
              _userBox.put("userDetails", userDetails);
              _userHiveBox.put('isLoggedIn', true);
              handelFcmStore();
            }

            if (data.containsKey("isNewuser")) {
              setState(() {
                isNewUser = true;
              });
              final user = data['isNewuser'] as Map<String, dynamic>;

              final userDetails = UserModel.fromJson(user);
              _userBox.put("userDetails", userDetails);
              _userHiveBox.put('isLoggedIn', true);
              handelFcmStore();
            }
            // handel the fcm store if google signup is success

            Navigator.pushAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
              (Route<dynamic> route) => false,
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(
            // ignore: use_build_context_synchronously
            context,
          ).showSnackBar(SnackBar(content: Text("Error google login $e")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Error google login $e")));
    }
  }

  // get the fcm token

  // handel fcm store in the database
  Future handelFcmStore() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    final fcmToken = await messaging.getToken();
    final Map<String, dynamic> formdata = {"email": email, "fcmToken": fcmToken};
    try {
      final res = await http.post(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/fcmtoken"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(formdata),
      );
      if (res.statusCode == 200) {
        debugPrint(res.body);
        if (isNewUser) {
          Future.delayed(Duration(seconds: 4), () {
            handelPwChangeNotify();
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // handel the change pw notificaiton
  Future handelPwChangeNotify() async {
    try {
      final res = await http.post(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/notifypwchange/$email"),
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        debugPrint("Sent notificaiton ");
      }
    } catch (e) {
      debugPrint("Error sending notificaiton $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        onPressed: handleGoogleSignIn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Continue with Google",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(width: 10),
            Image.asset("assets/icons/google.png", width: 15, height: 15),
          ],
        ),
      ),
    );
  }
}
