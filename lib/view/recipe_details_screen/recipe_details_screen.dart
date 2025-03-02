import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/recipe_details_controller.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:recipe_app/utils/utils_methods.dart';
import 'package:recipe_app/view/recipe_details_screen/widgets/review_sheet.dart';

class RecipeDetailsPage extends GetView<RecipeDetailsController> {
  const RecipeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = Get.arguments; // Get the passed recipe data
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Recipe Image with SliverAppBar effect
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: recipe.recipeImageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(),
                  child: Image.memory(
                    recipe.recipeImageUrl,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Draggable Scrollable Sheet
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Recipe Name Pinned
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                recipe.recipeName,
                                style: CustomStyle.titleLargeTextStyle.copyWith(
                                  color: ColorCode.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 24,
                                  ),

                                  Obx(
                                    () => Text(
                                      "${controller.averageRating.value.toStringAsFixed(1)}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "By ${recipe.createdByName}",
                                style: CustomStyle.titleMediumTextStyle
                                    .copyWith(
                                      color: ColorCode.kgrey,
                                      fontSize: 18,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    // isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) {
                                      return ReviewsBottomSheet(
                                        recipeId: recipe.recipeId,
                                      ); // Pass the commenter's name
                                    },
                                  );
                                },
                                child: Text(
                                  "Reviews",
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Category & Cooking Time
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${recipe.cookingTime} mins",
                                style: CustomStyle.hintTextStyle,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.category,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text(
                                recipe.category,
                                style: CustomStyle.hintTextStyle,
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          Text(
                            "Instructions",
                            style: CustomStyle.titleMediumTextStyle.copyWith(
                              color: ColorCode.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              recipe.instructions.length,
                              (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 10,
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        recipe.instructions[index],
                                        style: CustomStyle.hintTextStyle
                                            .copyWith(color: ColorCode.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Ingredients",
                            style: CustomStyle.titleMediumTextStyle.copyWith(
                              color: ColorCode.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              recipe.ingredients.length,
                              (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 10,
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        recipe.ingredients[index],
                                        style: CustomStyle.hintTextStyle
                                            .copyWith(color: ColorCode.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Instructions Section
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ⭐ Star Rating Row
                              const SizedBox(height: 12),

                              // 📝 Comment TextField
                              TextField(
                                style: TextStyle(color: Colors.black),
                                controller: controller.commentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "Write your feedback...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        size: 32,
                                        color:
                                            index <
                                                    controller
                                                        .selectedRating
                                                        .value
                                                ? Colors.orange
                                                : Colors.grey,
                                      ),
                                      onPressed: () {
                                        controller.rating(index);
                                      },
                                    );
                                  }),
                                ),
                              ),

                              // 🚀 Submit & Cancel Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                    ),
                                    onPressed: () {
                                      controller.submitComment(recipe.recipeId);
                                    },
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Back Button
            Positioned(
              top: 40,
              left: 15,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Obx(
          () => SizedBox(
            width: 250,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    controller.isFavorite.value ? Colors.teal : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (controller.isFavorite.value) {
                  controller.removeFromFavorites(
                    recipe.recipeId,
                  ); // Remove from favorites
                } else {
                  controller.addToFavorites(
                    recipe.recipeId,
                  ); // Add to favorites
                }
              },
              child: Text(
                controller.isFavorite.value
                    ? "Remove from Favorites"
                    : "Add to Favorites",
                style: CustomStyle.titleLargeTextStyle.copyWith(fontSize: 22),
              ),
            ),
          ),
        ),
        // floatingActionButton:
      ),
    );
  }
}
