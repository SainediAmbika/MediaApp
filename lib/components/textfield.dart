import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecureText;
  const MyTextField({super.key, required this.controller, required this.hintText, required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white),
    );
  }
}
