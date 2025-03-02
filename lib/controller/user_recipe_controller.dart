import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/controller/home_controller.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/utils/app_snackbar.dart';

class UserRecipesController extends GetxController {
  var isLoading = false.obs;
  var userRecipes = <RecipeModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    fetchUserRecipes();
    super.onInit();
  }

  void fetchUserRecipes() async {
    isLoading.value = true;
    try {
      User? user = _auth.currentUser; // Get the currently logged-in user
      print(" Current User: $user");
      if (user == null) {
        isLoading.value = false;
        AppSnackBar.error(message: "User not logged in");
        return;
      }

      QuerySnapshot snapshot =
          await _firestore
              .collection(tableRecipes)
              .where(keyCreatedBy, isEqualTo: user.uid) // Use actual user ID
              .get();

      userRecipes.assignAll(
        snapshot.docs.map(
          (doc) => RecipeModel.fromJson(doc.data() as Map<String, dynamic>),
        ),
      );
      print("Total recipes: ${userRecipes.length}");
    } catch (e) {
      AppSnackBar.error(message: "failed to fetch recipes");

      print("Error fetching recipes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void deleteRecipe(String recipeId) async {
    try {
      // Reference to the recipe document
      DocumentReference recipeRef = _firestore
          .collection(tableRecipes)
          .doc(recipeId);

      // Get all documents in the 'comments' subcollection
      QuerySnapshot commentsSnapshot =
          await recipeRef.collection(tableComments).get();

      // Delete each comment document
      for (QueryDocumentSnapshot doc in commentsSnapshot.docs) {
        await recipeRef.collection(tableComments).doc(doc.id).delete();
      }

      // Delete the recipe document after deleting all subcollection documents
      await recipeRef.delete();

      // Remove the recipe from the local list
      userRecipes.removeWhere((recipe) => recipe.recipeId == recipeId);
      Get.find<HomeController>().fetchRecipes();
      AppSnackBar.success(
        message: "Recipe and its comments deleted successfully",
        title: "Success",
      );
    } catch (e) {
      AppSnackBar.error(message: "Failed to delete recipe and comments");
      print("Error deleting recipe and comments: $e");
    }
  }
}
