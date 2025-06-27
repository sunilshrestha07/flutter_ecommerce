import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  // handel form submition
  void handelSubmit() {
    final email = _emailController.text.trim();

    debugPrint(" $email ");
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
                "Forgot Password",
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 50),
              Text(
                style: TextStyle(fontSize: 13),
                "Please, enter your email address. You will receive a link to create a new password via email.",
              ),
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
                          return "Not a valid email is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                        child: Text("Login"),
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
