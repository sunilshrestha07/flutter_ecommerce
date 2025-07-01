import 'dart:convert';

import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class Validate extends StatefulWidget {
  final String email;
  const Validate({super.key, required this.email});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  final _userHiveBox = Hive.box("userHiveBox");

  bool isValidating = false;
  final _formKey = GlobalKey<FormState>();

  final _code1 = TextEditingController();
  final _code2 = TextEditingController();
  final _code3 = TextEditingController();
  final _code4 = TextEditingController();
  final _code5 = TextEditingController();
  final _code6 = TextEditingController();

  // handel form submition
  void handelSubmit() async {
    setState(() {
      isValidating = true;
    });
    final code =
        _code1.text + _code2.text + _code3.text + _code4.text + _code5.text + _code6.text;
    final Map<String, dynamic> formData = {
      "email": widget.email,
      "verificationCode": code,
    };

    try {
      final response = await http.post(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/user/verify"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        _userHiveBox.add({"isLoggedIn": true});
        isValidating = false;
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        debugPrint("Error validation");
      }
    } catch (e) {
      isValidating = false;
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Validation Error $e")));
    } finally {
      if (mounted) {
        setState(() {
          isValidating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                "Verification Code",
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                    "We have sent the Verification code to your email address",
                  ),
                ),
              ),
              SizedBox(height: 30),
              // form for the input
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            controller: _code1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: _code2,
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: _code3,
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: _code4,
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: _code5,
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextFormField(
                            controller: _code6,
                            onChanged: (value) => {
                              if (value.length == 1) {FocusScope.of(context).nextFocus()},
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge, //textTheme bata bodyMedium ko color use garya

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "All code are required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    SizedBox(height: 30),
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
                        onPressed: handelSubmit,
                        child: Text("Validate"),
                      ),
                    ),
                    SizedBox(height: 60),
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
