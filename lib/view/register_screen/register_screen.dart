import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:recipe_app/controller/auth_controller.dart';
import 'package:recipe_app/resources/custom_widgets.dart';
import 'package:recipe_app/router/routs_names.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.2,
            image: AssetImage("assets/images/pexels-valeriya-842571.jpg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                appTitle(),
                SizedBox(height: 20),
                Text(
                  "Find Your Next Favorite Dish With Tasty",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30), // Adjust spacing
                // Profile Image Picker
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Obx(
                        () => CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              controller.selectedImagePath.value.isNotEmpty
                                  ? FileImage(
                                    File(controller.selectedImagePath.value),
                                  )
                                  : const AssetImage(
                                        "assets/images/profile_placeholder.png",
                                      )
                                      as ImageProvider,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Email Input
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    // Password Input
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordObscured.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordObscured.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              controller.isPasswordObscured.toggle();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.registerUser(),
                        child: Text("Register"),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),

                // Login Navigation
                TextButton(
                  onPressed: () => Get.toNamed(RoutsNames.login),
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
