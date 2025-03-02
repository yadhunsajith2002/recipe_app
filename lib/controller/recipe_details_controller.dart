import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/utils/app_snackbar.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';
import 'package:recipe_app/utils/utils_methods.dart';

class RecipeDetailsController extends GetxController {
  var isFavorite = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var selectedRating = 0.obs; // Stores selected star count
  TextEditingController commentController = TextEditingController();

  var averageRating = 0.0.obs; // Store fetched rating
  var totalReviews = 0.obs; // Store total review count

  late String recipeId;

  @override
  void onInit() {
    super.onInit();
    recipeId = Get.arguments.recipeId; // Get the passed recipe ID
    checkIfFavorite(recipeId); // Check if the recipe is favorited
    fetchAverageRating(recipeId); // Fetch rating on init
  }

  void rating(int index) {
    selectedRating.value = index + 1;
  }

  void fetchAverageRating(String recipeId) async {
    try {
      var snapshot =
          await _firestore
              .collection(tableRecipes)
              .doc(recipeId)
              .collection(tableComments)
              .get();

      if (snapshot.docs.isNotEmpty) {
        double totalRating = 0;
        snapshot.docs.forEach((doc) {
          totalRating += doc[keyRatings];
        });
        print("Total Rating: $totalRating");
        averageRating.value = totalRating / snapshot.docs.length;
        totalReviews.value = snapshot.docs.length;
        print("Total Rating: ${averageRating.value}");
      } else {
        averageRating.value = 0.0;
        totalReviews.value = 0;
      }
    } catch (e) {
      print("Error fetching rating: $e");
    }
  }

  Future<void> submitComment(String recipeId) async {
    if (commentController.text.isEmpty || selectedRating.value == 0) {
      Get.snackbar("Error", "Please provide a comment and rating.");
      return;
    }

    try {
      User? user = _auth.currentUser; // Get current user
      if (user == null) {
        Get.snackbar("Error", "User not logged in.");
        return;
      }

      String userId = user.uid;
      String userName =
          GetStorageManager.getValue(
            prefEmail,
            "",
          ).split('@').first.toString().firstCapitalize();

      await _firestore
          .collection(tableRecipes)
          .doc(recipeId)
          .collection(tableComments)
          .add({
            keyUserId: userId,
            keyUserName: userName,
            keyComments: commentController.text,
            keyRatings: selectedRating.value,
            "timestamp": FieldValue.serverTimestamp(),
          });

      AppSnackBar.success(
        title: "Success",
        message: "Your comment has been submitted.",
      );
      commentController.clear();
      selectedRating.value = 0;
    } catch (e) {
      AppSnackBar.success(title: "Error", message: "Failed to submit comment");
    }
  }

  Future<void> checkIfFavorite(String recipeId) async {
    var user = _auth.currentUser;
    if (user != null) {
      var doc = await _firestore.collection(tableUsers).doc(user.uid).get();
      if (doc.exists) {
        List<dynamic> favoriteRecipes = doc.data()?[keyFavoriteRecipes] ?? [];
        isFavorite.value = favoriteRecipes.contains(recipeId);
      } else {
        isFavorite.value = false;
      }
    }
  }

  // Function to add a recipe to favorites
  Future<void> addToFavorites(String recipeId) async {
    var user = _auth.currentUser;
    if (user != null) {
      var userRef = _firestore.collection(tableUsers).doc(user.uid);

      await userRef.update({
        keyFavoriteRecipes: FieldValue.arrayUnion([recipeId]),
      });

      isFavorite.value = true;
    }
  }

  // Fetch the user's favorite recipes

  Future<void> removeFromFavorites(String recipeId) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection(tableUsers)
          .doc(user.uid)
          .update({
            keyFavoriteRecipes: FieldValue.arrayRemove([recipeId]),
          });
      isFavorite.value = false; // Update UI state
    }
  }
}
