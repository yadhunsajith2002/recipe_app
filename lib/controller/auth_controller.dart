import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/utils/utils_methods.dart';
import '../firebase/firebase_api.dart';
import '../model/default_response.dart';
import '../router/routs_names.dart';
import '../utils/app_snackbar.dart';
import '../utils/show_progress_dialog.dart';
import '../utils/get_storage_manager.dart';
import 'auth_controller.dart' as firebaseApi;

class AuthController extends GetxController {
  final FirebaseApi firebaseApi = FirebaseApi();
  final progressDialog = ShowProgressDialog();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  var selectedImagePath = "".obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  final isPasswordObscured = true.obs;

  /// ✅ Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  /// ✅ Pick Image from Gallery
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// ✅ Register User
  Future<void> registerUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    final image = selectedImage.value;

    if (email.isEmpty || password.isEmpty || image == null) {
      AppSnackBar.error(
        message: "Please fill all fields and select a profile image.",
      );
      return;
    }

    progressDialog.show();
    DefaultResponse response = await firebaseApi.registerUser(
      email: email,
      password: password,
      profileImage: image,
    );
    progressDialog.hide();

    if (response.status!) {
      GetStorageManager.setValue(prefIsLoggedIn, true);
      GetStorageManager.setValue(prefEmail, email);
      // GetStorageManager.setValue(prefUserName, username);
      GetStorageManager.setValue(prefProfilePicture, image.path);
      AppSnackBar.success(message: response.message);
      Get.offAllNamed(RoutsNames.main);
    } else {
      AppSnackBar.error(message: response.message);
    }
  }

  /// ✅ Login User
  Future<void> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      AppSnackBar.error(message: "Email and password cannot be empty.");
      return;
    }

    progressDialog.show();
    DefaultResponse defaultResponse = await firebaseApi.loginUser(
      email: email,
      password: password,
    );
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (defaultResponse.status == false) {
        progressDialog.hide();
        AppSnackBar.error(message: defaultResponse.message);
        return;
      }
      progressDialog.hide();

      User? currentUser;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: defaultResponse.responseData[keyEmail],
            password: password,
          )
          .then((auth) {
            currentUser = auth.user;
            progressDialog.show();
            GetStorageManager.setValue(prefIsLoggedIn, true);
            GetStorageManager.setValue(
              prefProfilePicture,
              getDocumentValue(
                documentSnapshot: defaultResponse.responseData,
                key: keyProfilePicture,
              ),
            );
            GetStorageManager.setValue(
              prefEmail,
              defaultResponse.responseData[keyEmail],
            );
            GetStorageManager.setValue(
              keyPassword,
              defaultResponse.responseData[keyPassword],
            );
            GetStorageManager.setValue(
              keyCreatedAt,
              getDocumentValue(
                documentSnapshot: defaultResponse.responseData,
                key: keyCreatedAt,
              ),
            );
            GetStorageManager.setValue(
              prefUserId,
              (defaultResponse.responseData as DocumentSnapshot).id,
            );
            AppSnackBar.success(message: defaultResponse.message);
            Get.offAllNamed(RoutsNames.main);
          })
          .catchError((error) {
            progressDialog.hide();
            debugPrint('error.message!${error.message}');
            AppSnackBar.error(message: error.message);
          });
    } else {
      progressDialog.hide();
      AppSnackBar.error(message: "Something want to wrong. Please try again");
    }
  }

  /// ✅ Logout User
  Future<void> logoutUser() async {
    await firebaseApi.logoutUser();
    GetStorageManager.removeValue(prefIsLoggedIn);
    GetStorageManager.removeValue(prefEmail);
    GetStorageManager.removeValue(prefUserName);
    GetStorageManager.removeValue(prefProfilePicture);

    Get.offAllNamed(RoutsNames.login);
  }
}
