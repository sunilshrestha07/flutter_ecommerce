import 'dart:convert';

import 'package:ecommerce/features/authentication/views/login.dart';
import 'package:ecommerce/features/authentication/views/validate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLogging = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // handel form submition
  Future handelSubmit() async {
    setState(() {
      isLogging = true;
    });
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final Map<String, dynamic> formData = {
      "userName": name,
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/user/signup"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLogging = false;
        });
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => Validate(email: email)),
        );
      } else {
        setState(() {
          isLogging = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 230, 87, 77),
              content: Text("Error signing up! please try again"),
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLogging = false;
      });
      debugPrint("Error signup $e");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error $e")));
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
                "Sign Up",
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 50),
              // form for the input
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium, //textTheme bata bodyMedium ko color use garya
                      decoration: InputDecoration(hintText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
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
                        if (value == null || value.length < 6 || value.isEmpty) {
                          return "Password is required and should be minimum 6 charatcter";
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
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            "Already have an account?",
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
                            : Text("Sign up"),
                      ),
                    ),
                    SizedBox(height: 60),

                    // google login
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(Colors.white),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              style: TextStyle(color: Colors.black, fontSize: 15),
                              "continue with google",
                            ),
                            SizedBox(width: 10),
                            Image.asset(width: 15, height: 15, "assets/icons/google.png"),
                          ],
                        ),
                      ),
                    ),
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
