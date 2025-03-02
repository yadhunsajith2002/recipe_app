import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/favorite_controller.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:recipe_app/router/routs_names.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorite Recipes", style: CustomStyle.titleLargeTextStyle),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<RecipeModel>>(
        stream: controller.favoriteRecipesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No favorite recipes yet!"));
          }

          List<RecipeModel> favoriteRecipes = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, index) {
              RecipeModel recipe = favoriteRecipes[index];

              return SizedBox(
                width: double.infinity,
                height: height * 0.16,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Get.toNamed(RoutsNames.recipeDetails, arguments: recipe);
                    },
                    child: Row(
                      children: [
                        // Recipe Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:
                              recipe.recipeImageUrl.isNotEmpty
                                  ? Image.memory(
                                    recipe.recipeImageUrl,
                                    width: width * 0.15,
                                    height: height * 0.15,
                                    fit: BoxFit.cover,
                                  )
                                  : Container(
                                    width: 100,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(
                                      Icons.fastfood,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                        ),

                        // Recipe Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.recipeName,
                                  style: CustomStyle.titleMediumTextStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Category :  ${recipe.category}",
                                  style: CustomStyle.titleSmallTextStyle
                                      .copyWith(color: ColorCode.kgrey),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${recipe.cookingTime} Minutes",
                                      style: CustomStyle.titleSmallTextStyle
                                          .copyWith(color: ColorCode.kgrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Delete Button
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () async {
                              await controller.removeFromFavorites(
                                recipe.recipeId,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutsNames.addRecipe);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
