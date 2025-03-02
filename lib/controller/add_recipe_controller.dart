import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/controller/home_controller.dart';
import 'package:recipe_app/firebase/firebase_api.dart';

import 'package:recipe_app/utils/app_snackbar.dart';

class RecipeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseApi firebaseApi = FirebaseApi();
  final recipeNameController = TextEditingController();
  final cookingTimeController = TextEditingController();
  var ingredients = <TextEditingController>[].obs;
  var instructions = <TextEditingController>[].obs;
  var selectedImage = Rx<File?>(null);
  var recipeCategories =
      <String>["Desserts", "Breakfast", "Lunch", "Dinner", "Snacks"].obs;
  var selectedCategory = "Snacks".obs;
  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ingredients.add(TextEditingController());
    instructions.add(TextEditingController());
  }

  void addIngredient() {
    ingredients.add(TextEditingController());
  }

  void removeIngredient(int index) {
    if (ingredients.length > 1) ingredients.removeAt(index);
  }

  void addInstruction() {
    instructions.add(TextEditingController());
  }

  void removeInstruction(int index) {
    if (instructions.length > 1) instructions.removeAt(index);
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  bool validateFields() {
    if (recipeNameController.text.isEmpty) {
      AppSnackBar.error(message: "Recipe name is required");

      return false;
    }

    if (ingredients.isEmpty ||
        ingredients.any((element) => element.text.isEmpty)) {
      AppSnackBar.error(message: "At least one ingredient is required");

      return false;
    }

    if (instructions.isEmpty ||
        instructions.any((element) => element.text.isEmpty)) {
      AppSnackBar.error(message: "At least one instruction step is required");

      return false;
    }

    if (cookingTimeController.text.isEmpty ||
        int.tryParse(cookingTimeController.text) == null) {
      AppSnackBar.error(message: "Valid cooking time is required");

      return false;
    }

    if (selectedImage.value == null) {
      AppSnackBar.error(message: "Please upload an image");

      return false;
    }

    return true;
  }

  Future<void> submitRecipe() async {
    if (!validateFields()) return;
    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        AppSnackBar.error(message: "User not authenticated!");
        isLoading.value = false;
        return;
      }

      String createdByName = getUserNameFromEmail(user.email ?? "Unknown");

      await firebaseApi.addNewRecipe(
        servings: 1,
        recipeName: recipeNameController.text.trim(),
        ingredients: ingredients.map((e) => e.text.trim()).toList(),
        instructions: instructions.map((e) => e.text.trim()).toList(),
        cookingTime: cookingTimeController.text.trim(),
        category: selectedCategory.value,
        recipeImageUrl: selectedImage.value!,
        createdByName: createdByName,
      );
      AppSnackBar.success(message: "Recipe added successfully!");
      await Future.delayed(Duration(seconds: 2));

      _clearFields();
      Get.back();
      Get.find<HomeController>().fetchRecipes(); // ✅ Fetch new data
    } catch (e) {
      AppSnackBar.error(message: "Failed to add recipe: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFields() {
    recipeNameController.clear();
    cookingTimeController.clear();
    ingredients.clear();
    instructions.clear();
    selectedImage.value = null;
    ingredients.add(TextEditingController());
    instructions.add(TextEditingController());
  }

  String getUserNameFromEmail(String email) {
    return email.split('@').first; // Extracts the part before '@'
  }
}
