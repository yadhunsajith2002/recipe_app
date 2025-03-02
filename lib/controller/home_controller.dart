import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/firebase/firebase_api.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';

import 'package:recipe_app/utils/app_snackbar.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late PageController pageController;
  late ScrollController scrollController;
  var allRecipes = <RecipeModel>[].obs; // All recipes
  var filteredRecipes = <RecipeModel>[].obs; // Filtered recipes
  var selectedIndex = 0.obs; // Track the selected index
  var recipeSections =
      <String>["All", "Desserts", "Breakfast", "Lunch", "Dinner", "Snacks"].obs;
  var categoryImages = [
    "https://static.vecteezy.com/system/resources/previews/049/655/073/non_2x/a-plate-full-of-different-types-of-food-png.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3Q6eTFhQMRPM2LCVlUvypQlWy5rLF56otTgyRGT2nOcy9SJYHbI_eWlKmdm0m2LALAWw&usqp=CAU",
    "https://w7.pngwing.com/pngs/250/932/png-transparent-breakfast-platter-fish-and-chips-full-breakfast-baked-beans-toast-traditional-food-recipe-breakfast.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRfWOnQlnlW715NRgn8eGCzSh99lmh8i-w9w&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCKBrPALhbP6OssurWZZr1VplPij9uzg2gHA&s",
    "https://img.freepik.com/free-psd/assorted-snack-platter-delicious-crackers-crispy-chips-tasty-treats-wooden-bowl-yummy-appetizer_632498-30357.jpg",
  ];

  var caouselImages = [
    "https://images.pexels.com/photos/1640773/pexels-photo-1640773.jpeg?cs=srgb&dl=pexels-ella-olsson-572949-1640773.jpg&fm=jpg",
    "https://images.unsplash.com/photo-1543353071-087092ec393a?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGxhbnQlMjBiYXNlZCUyMGZvb2R8ZW58MHx8MHx8fDA%3D",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeY1PTEAEn5NsFhIsp9lDcSfiHOgY5gSuzVg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxAUF3Yq_4gTht_QZLyXlRW2AXwGsNm97BN7qh4M_-EQ0C2_P9fVqOQwtBiCPd18gKTF4&usqp=CAU",
    "https://wallpapers.com/images/hd/food-4k-m37wpodzrcbv5gvw.jpg",
  ];
  var isLoading = false.obs;
  var selectedSection = RxString("All"); // Ensure it's reactive
  final FirebaseApi firebaseApi = FirebaseApi();
  Rx<Uint8List?> profileImageBytes = Rx<Uint8List?>(null);
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  RxBool isSearching = false.obs;
  RxList<String> recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
    fetchRecipesStream();

    searchFocusNode.addListener(() {
      isSearching.value = searchFocusNode.hasFocus;
    });
  }

  void onTap(int index) {
    selectedIndex.value = index;
    selectedSection.value =
        recipeSections[index]; // Store the selected category
    filterRecipes();
  }

  Stream<List<RecipeModel>> fetchRecipesStream() {
    return FirebaseFirestore.instance.collection(tableRecipes).snapshots().map((
      querySnapshot,
    ) {
      return querySnapshot.docs
          .map((doc) => RecipeModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> fetchRecipes() async {
    try {
      isLoading.value = true;
      var snapshot = await _firestore.collection(tableRecipes).get();
      var recipes =
          snapshot.docs.map((doc) => RecipeModel.fromJson(doc.data())).toList();

      allRecipes.assignAll(recipes);
      filterRecipes(); // Filter recipes after fetching
    } catch (e) {
      AppSnackBar.error(message: "Failed to fetch recipes");
    } finally {
      isLoading.value = false;
    }
  }

  void filterRecipes() {
    if (selectedSection.value == "All") {
      filteredRecipes.assignAll(allRecipes); // Show all recipes
    } else {
      filteredRecipes.assignAll(
        allRecipes
            .where((recipe) => recipe.category == selectedSection.value)
            .toList(),
      );
    }
  }

  void searchRecipes(String query) {
    if (query.isEmpty) {
      filteredRecipes.assignAll(allRecipes);
    } else {
      filteredRecipes.assignAll(
        allRecipes.where(
          (recipe) =>
              recipe.recipeName.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
