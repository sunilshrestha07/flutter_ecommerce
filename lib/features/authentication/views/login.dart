import 'dart:convert';

import 'package:ecommerce/common/widgets/oauth.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/views/forgot.dart';
import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userBox = Hive.box<UserModel>("userDetailsHiveBox");
  bool isLogging = false;
  final _formKey = GlobalKey<FormState>();
  final _userHiveBox = Hive.box("userHiveBox");

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // handel form submition
  Future handelSubmit() async {
    setState(() {
      isLogging = true;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final Map<String, dynamic> formData = {"email": email, "password": password};
    try {
      final response = await http.post(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/user/login"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['user'] as Map<String, dynamic>;
        final userDetails = UserModel.fromJson(user);
        _userBox.put("userDetails", userDetails);
        _userHiveBox.put('isLoggedIn', true);
        setState(() {
          isLogging = false;
        });
        Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
          (Route<dynamic> route) => false,
        );
      } else {
        debugPrint("error loggingin");
        setState(() {
          isLogging = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Credential Error ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        isLogging = false;
      });
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 70, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                "Login In",
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 50),
              // form for the input
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),

                    TextFormField(
                      controller: _emailController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium, //textTheme bata bodyMedium ko color use garya
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),

                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium, //textTheme bata bodyMedium ko color use garya
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Forgot()),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 243, 95, 84),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_right_alt,
                          color: const Color.fromARGB(255, 243, 95, 84),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            await handelSubmit();
                          }
                        },
                        child: isLogging
                            ? Center(child: CircularProgressIndicator())
                            : Text("Login"),
                      ),
                    ),
                    SizedBox(height: 60),

                    // google login
                    Oauth(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
