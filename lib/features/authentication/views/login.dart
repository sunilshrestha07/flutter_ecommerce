import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              "Sign Up",
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            TextFormField(
              style: TextStyle(),
              decoration: InputDecoration(hintText: "Name"),
            ),
          ],
        ),
      ),
    );
  }
}
