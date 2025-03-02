import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/splash_screen_controller.dart';
import 'package:recipe_app/resources/custom_widgets.dart';

class SplashScreen extends GetView<SplashScreenController> {
  SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/images/splash_logo.png",
            //   height: 150,
            // ), // Your app logo
            SizedBox(height: 20),
            appTitle(),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading Indicator
          ],
        ),
      ),
    );
  }
}
