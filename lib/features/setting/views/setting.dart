import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _emailController = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _userDeatilsBox = Hive.box<UserModel>("userDetailsHiveBox");
  List<UserModel> loggedInUser = [];
  bool isUpdating = false;

  // handel userupdate
  Future handelProfileUpdate() async {
    final Map<String, dynamic> formData = {};
    if (_emailController.text.isNotEmpty) {
      formData.addAll({"email": _emailController.text.trim()});
    }
    if (_username.text.isNotEmpty) {
      formData.addAll({"userName": _username.text.trim()});
    }
    if (_password.text.isNotEmpty) {
      formData.addAll({"password": _password.text.trim()});
    }

    if (formData.isEmpty) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("No changes to update"),
        ),
      );
      return;
    }
    try {
      setState(() {
        isUpdating = true;
      });
      final res = await http.put(
        Uri.parse(
          "https://fashion-fusion-suneel.vercel.app/api/user/${loggedInUser[0].sId}",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(formData),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final user = data['user'] as Map<String, dynamic>;
        final userDetails = UserModel.fromJson(user);
        _userDeatilsBox.put("userDetails", userDetails);
        setState(() {
          loggedInUser = _userDeatilsBox.values.toList();
          isUpdating = false;
          _emailController.clear();
          _username.clear();
          _password.clear();
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text("Successfully updated profile"),
          ),
        );
      } else {
        setState(() {
          isUpdating = false;
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text("Error Updating profile"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isUpdating = false;
      });
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Error Updating profile\n $e"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = _userDeatilsBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: loggedInUser[0].avatar.toString(),
                        placeholder: (context, url) => CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    loggedInUser[0].userName.toString(),
                  ),
                  Text(
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    loggedInUser[0].email.toString(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(label: Text("Username")),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _password,
                        decoration: InputDecoration(labelText: "New password"),
                      ),

                      SizedBox(height: 40),
                      SizedBox(
                        width: 160,
                        height: 40,
                        child: FilledButton(
                          onPressed: handelProfileUpdate,
                          child: isUpdating
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text("Update"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
