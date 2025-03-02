import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void success({
    String title = "Success",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    _showSnackbar(
      title: title,
      message: message ?? nullMessage,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void error({
    String title = "Error",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    _showSnackbar(
      title: title,
      message: message ?? nullMessage,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void warning({
    String title = "Warning",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    _showSnackbar(
      title: title,
      message: message ?? nullMessage,
      backgroundColor: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void info({
    String title = "Info",
    required String? message,
    String nullMessage = "Something went wrong",
  }) {
    _showSnackbar(
      title: title,
      message: message ?? nullMessage,
      backgroundColor: Colors.blue,
      icon: Icons.info_outline,
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Get.closeAllSnackbars(); // Close any existing snackbars

    Get.snackbar(
      "",
      "",
      titleText: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: backgroundColor.withOpacity(0.9),
      snackPosition: SnackPosition.TOP, // Can be changed to TOP
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: const Offset(2, 4),
        ),
      ],
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 3),
      maxWidth: getMaxWidth(),
    );
  }

  static double getMaxWidth() {
    return Get.width < 850 ? Get.width - 32 : Get.width / 2;
  }
}
