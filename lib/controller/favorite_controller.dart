// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/state_manager.dart';
// import 'package:recipe_app/model/recipe_model.dart';
// import 'package:recipe_app/resources/tables_keys_values.dart';

// class FavoriteController extends GetxController {
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     fetchFavoriteRecipes();
//     super.onInit();
//   }

//   Future<List<RecipeModel>> fetchFavoriteRecipes() async {
//     isLoading(true);
//     var user = FirebaseAuth.instance.currentUser;
//     if (user == null) return [];
//     var doc =
//         await FirebaseFirestore.instance
//             .collection(tableUsers)
//             .doc(user.uid)
//             .get();

//     if (doc.exists && doc.data()?[keyFavoriteRecipes] != null) {
//       List<dynamic> favoriteRecipeIds = doc.data()?[keyFavoriteRecipes];

//       List<RecipeModel> favoriteRecipes = [];

//       for (var recipeId in favoriteRecipeIds) {
//         var recipeDoc =
//             await FirebaseFirestore.instance
//                 .collection(tableRecipes)
//                 .doc(recipeId)
//                 .get();
//         if (recipeDoc.exists) {
//           favoriteRecipes.add(RecipeModel.fromJson(recipeDoc.data()!));
//         }
//       }
//       isLoading(false);
//       return favoriteRecipes;
//     }

//     return [];
//   }

//   Future<void> removeFromFavorites(String recipeId) async {
//     isLoading(true);
//     var user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await FirebaseFirestore.instance
//           .collection(tableUsers)
//           .doc(user.uid)
//           .update({
//             keyFavoriteRecipes: FieldValue.arrayRemove([recipeId]),
//           });
//       isLoading(false); // Update UI state
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';

class FavoriteController extends GetxController {
  var isLoading = false.obs;
  var favoriteRecipes = <RecipeModel>[].obs;

  Stream<List<RecipeModel>> get favoriteRecipesStream {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection(tableUsers)
        .doc(user.uid)
        .snapshots()
        .asyncMap((doc) async {
          if (doc.exists && doc.data()?[keyFavoriteRecipes] != null) {
            List<dynamic> favoriteRecipeIds = doc.data()?[keyFavoriteRecipes];

            List<RecipeModel> favoriteList = [];

            for (var recipeId in favoriteRecipeIds) {
              var recipeDoc =
                  await FirebaseFirestore.instance
                      .collection(tableRecipes)
                      .doc(recipeId)
                      .get();
              if (recipeDoc.exists) {
                favoriteList.add(RecipeModel.fromJson(recipeDoc.data()!));
              }
            }
            return favoriteList;
          } else {
            return [];
          }
        });
  }
  // Future<void> fetchFavoriteRecipes() async {
  //   isLoading(true);
  //   var user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     favoriteRecipes.clear();
  //     isLoading(false);
  //     return;
  //   }

  //   var doc =
  //       await FirebaseFirestore.instance
  //           .collection(tableUsers)
  //           .doc(user.uid)
  //           .get();

  //   if (doc.exists && doc.data()?[keyFavoriteRecipes] != null) {
  //     List<dynamic> favoriteRecipeIds = doc.data()?[keyFavoriteRecipes];

  //     List<RecipeModel> favoriteList = [];

  //     for (var recipeId in favoriteRecipeIds) {
  //       var recipeDoc =
  //           await FirebaseFirestore.instance
  //               .collection(tableRecipes)
  //               .doc(recipeId)
  //               .get();
  //       if (recipeDoc.exists) {
  //         favoriteList.add(RecipeModel.fromJson(recipeDoc.data()!));
  //       }
  //     }

  //     favoriteRecipes.assignAll(favoriteList);
  //   } else {
  //     favoriteRecipes.clear();
  //   }

  //   isLoading(false);
  // }

  Future<void> removeFromFavorites(String recipeId) async {
    isLoading(true);
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection(tableUsers)
          .doc(user.uid)
          .update({
            keyFavoriteRecipes: FieldValue.arrayRemove([recipeId]),
          });

      favoriteRecipes.removeWhere((recipe) => recipe.recipeId == recipeId);
    }
    isLoading(false);
  }
}
