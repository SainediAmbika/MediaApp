import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final retEnterPaswdController = TextEditingController();

  displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  void signUp() async {
    if (passwordTextController.text != retEnterPaswdController.text) {
      Navigator.pop(context);

      displayMessage("check your password");
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      displayMessage("correct it $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
          backgroundColor: fromCssColor('#6291AC'),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Icon(
                    Icons.lock,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                MyTextField(
                  hintText: "Email",
                  obsecureText: false,
                  controller: emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: passwordTextController, hintText: "Password", obsecureText: true),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: retEnterPaswdController, hintText: "Password", obsecureText: true),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: const Text("Sign Up")),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                    ),
                    const Text("Existing user ?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: widget.onTap, child: const Text("Login", style: TextStyle(color: Colors.blue)))
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
