import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType inputType;
  final Icon icon;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.isPass = false,
    required this.hintText,
    required this.inputType,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPass,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        icon: icon,
        iconColor: Colors.grey,
        hintText: hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
