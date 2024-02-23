import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:mediaapp/authorization/login_register.dart';

import '../screens/home_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fromCssColor('#6291AC'),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, index) {
            if (index.hasData) {
              return const HomePage();
            } else {
              return const LoginOrRigester();
            }
          }),
    );
  }
}
