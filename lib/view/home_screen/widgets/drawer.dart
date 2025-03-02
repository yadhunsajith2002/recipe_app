import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:recipe_app/controller/profile_controller.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';
import 'package:recipe_app/utils/utils_methods.dart';

class DrawerWidget extends StatelessWidget {
  final ProfileController controller;

  const DrawerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.teal, // Header background color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child:
                          controller.profileImageBytes.value != null
                              ? Image.memory(
                                controller.profileImageBytes.value!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hello, ${GetStorageManager.getValue(prefEmail, "").split('@').first.toString().firstCapitalize()}",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () => controller.logoutUser(),
          ),
        ],
      ),
    );
  }
}
