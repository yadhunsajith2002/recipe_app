import 'package:flutter/material.dart';
import 'package:recipe_app/resources/color_code.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.maxLines = 1,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.obscureText = true,
    this.toggleVisibility,
    this.hintText = "Enter",
  });

  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final bool isPassword;
  final String? hintText;

  final bool obscureText;
  final VoidCallback? toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
            color: Colors.grey.shade500,
          ),
          fillColor: ColorCode.ktextfieldClr,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
