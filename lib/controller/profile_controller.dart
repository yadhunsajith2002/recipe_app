import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/router/routs_names.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("IMAGE : ${profileImageBytes}");
    loadProfileImage();
  }

  Rx<Uint8List?> profileImageBytes = Rx<Uint8List?>(null);
  Future<void> logoutUser() async {
    var isRemember = GetStorageManager.getValue(prefRemember, false);
    var email = GetStorageManager.getValue(prefEmail, "");
    var pass = GetStorageManager.getValue(prefPassword, "");
    GetStorageManager.clear();
    if (isRemember) {
      GetStorageManager.setValue(prefEmail, email);
      GetStorageManager.setValue(prefPassword, pass);
      GetStorageManager.setValue(prefRemember, isRemember);
    }
    Get.offAllNamed(RoutsNames.launcher);
  }

  void loadProfileImage() {
    String imagePath = GetStorageManager.getValue(prefProfilePicture, "");

    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      Uint8List imageBytes = File(imagePath).readAsBytesSync();
      profileImageBytes.value = imageBytes;
    }
  }

  void saveProfileImage(String imagePath) {
    GetStorageManager.setValue(prefProfilePicture, imagePath);
    loadProfileImage(); // Reload image after saving
  }
}
