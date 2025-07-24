import 'dart:convert';

import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/home/views/homepage.dart';
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
  final _userBox = Hive.box<UserModel>("userDetailsHiveBox");
  final _userHiveBox = Hive.box("userHiveBox");
  // Handle Google Sign-In
  Future<void> handleGoogleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

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
            final user = data['user'] as Map<String, dynamic>;
            final userDetails = UserModel.fromJson(user);
            _userBox.put("userDetails", userDetails);
            _userHiveBox.put('isLoggedIn', true);

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

      // Get authentication details
      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken, // FIXED: Use googleAuth.idToken
      // );

      // Sign in with Firebase
      // final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // print('User signed in: ${userCredential.user?.displayName}');
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Error google login $e")));
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
