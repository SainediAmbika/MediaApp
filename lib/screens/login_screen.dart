import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../components/textfield.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      displayMessage(e.code);
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
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: const Text("Login")),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    const Text("Not a member ?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: widget.onTap, child: const Text("Register now", style: TextStyle(color: Colors.white))),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
