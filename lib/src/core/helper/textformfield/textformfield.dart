import 'package:flutter/material.dart';

class TextFormFieldBuilder extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int? minLength;
  final bool obscureText;

  const TextFormFieldBuilder(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.minLength,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (minLength != null && value.length < minLength!) {
          return 'Enter at least $minLength characters';
        }
        if (keyboardType == TextInputType.emailAddress &&
            !isValidEmail(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

  bool isValidEmail(String email) {
    // Validating email format using a simple regex
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }
}
