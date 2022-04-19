import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  const RoundedTextBox({
    required this.onChanged,
    this.label = 'Enter text...',
    this.obscureText = false,
    this.keyboard = TextInputType.text,
    this.controller,
    Key? key,
  }) : super(key: key);

  final String label;
  final bool obscureText;
  final TextInputType keyboard;
  final Function(String) onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          labelText: label,
        ),
        keyboardType: keyboard,
        obscureText: obscureText,
        onChanged: onChanged,
      ),
    );
  }
}
