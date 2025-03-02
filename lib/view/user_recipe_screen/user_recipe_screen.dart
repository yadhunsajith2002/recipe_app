import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/user_recipe_controller.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class UserRecipesScreen extends GetView<UserRecipesController> {
  const UserRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Recipes", style: CustomStyle.titleLargeTextStyle),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.userRecipes.isEmpty) {
          return Center(child: Text("You haven't added any recipes yet."));
        }
        return ListView.builder(
          itemCount: controller.userRecipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.userRecipes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Card(
                child: ListTile(
                  minVerticalPadding: 30,
                  title: Text(
                    recipe.recipeName,
                    style: CustomStyle.titleMediumTextStyle,
                  ),
                  // subtitle: Text(recipe.re),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:
                        recipe.recipeImageUrl.isNotEmpty
                            ? Hero(
                              tag: recipe.recipeImageUrl,
                              child: Image.memory(
                                recipe.recipeImageUrl,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Container(
                              height: 60,
                              width: 60,
                              color:
                                  Colors.grey[300], // Placeholder if no image
                              child: Icon(Icons.image, color: Colors.grey[600]),
                            ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed:
                            () => _showDeleteDialog(context, recipe.recipeId),
                      ),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.grey),
                        onPressed: () {
                          _shareRecipe(
                            recipe.recipeName,
                            recipe.recipeImageUrl,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showDeleteDialog(BuildContext context, String recipeId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(25),
      title: "Delete Recipe",
      middleText: "Are you sure you want to delete this recipe?",
      textConfirm: "Yes, Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () {
        controller.deleteRecipe(recipeId);
        Get.back();
      },
    );
  }

  void _shareRecipe(String recipeName, Uint8List imageBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/recipe_image.jpg');

      await file.writeAsBytes(imageBytes);

      // Use FileProvider URI
      final xFile = XFile(file.path, mimeType: 'image/jpeg');

      await Share.shareXFiles([
        xFile,
      ], text: "Check out this recipe: $recipeName!");
    } catch (e) {
      print("Error sharing recipe: $e");
    }
  }
}
