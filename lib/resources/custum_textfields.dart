import 'package:flutter/material.dart';

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
  });

  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final bool isPassword;

  final bool obscureText;
  final VoidCallback? toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          obscureText: isPassword ? obscureText : false,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
            hintText: "Enter",
            fillColor: const Color(0xffFBFBFB),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey.shade500,
                      ),
                      onPressed: toggleVisibility,
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
