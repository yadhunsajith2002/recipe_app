import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/home_controller.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/router/routs_names.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';
import 'package:recipe_app/utils/utils_methods.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        hideKeyboard();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.fetchRecipes();
            },
            child: GestureDetector(
              onTap: () {
                hideKeyboard();
              },
              child: CustomScrollView(
                physics:
                    const AlwaysScrollableScrollPhysics(), // Ensure scrolling is always enabled
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior
                        .onDrag, // Hide keyboard when scrolling
                slivers: [
                  SliverAppBar(
                    expandedHeight: height * 0.18,
                    // floating: true,
                    toolbarHeight: height * 0.18,
                    automaticallyImplyLeading: false,
                    titleSpacing: 20,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CarouselSlider.builder(
                        itemCount: controller.caouselImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final image = controller.caouselImages[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                opacity: 0.8,
                                fit: BoxFit.cover,
                                image: NetworkImage(image),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          height: 250,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Hello, ${GetStorageManager.getValue(prefEmail, "").split('@').first.toString().firstCapitalize()}",
                            style: CustomStyle.titleLargeTextStyle,
                          ),
                          Text(
                            getGreeting(), // ✅ Dynamically set greeting
                            style: CustomStyle.titleLargeTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverAppBar(
                    // backgroundColor: Colors.teal.shade900,
                    expandedHeight: height * 0.12,
                    toolbarHeight: height * 0.12,
                    pinned: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    title: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        onChanged: (value) => controller.searchRecipes(value),
                        onSubmitted: (value) {
                          controller.searchFocusNode.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Search recipes",
                          hintStyle: CustomStyle.hintTextStyle,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: ColorCode.kgrey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: ColorCode.kgrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 10);
                        },
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10,
                        ),
                        itemCount: controller.recipeSections.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: ColorCode.black,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              controller.onTap(index);
                            },
                            child: Obx(
                              () => Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedIndex.value == index
                                          ? ColorCode.mainColor
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            controller.categoryImages[index],
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      controller.recipeSections[index],
                                      style: CustomStyle.titleSmallTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // Recipes Grid
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (controller.filteredRecipes.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: Text(
                                  "Oops nothing here...",
                                  style: CustomStyle.emptyListTextStyle,
                                ),
                              ),
                            );
                          }
                          return GridView.builder(
                            shrinkWrap:
                                true, // Ensures GridView takes only necessary space
                            physics:
                                NeverScrollableScrollPhysics(), // Disables GridView scrolling
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 15,
                              right: 15,
                              bottom: 80,
                            ),
                            itemCount: controller.filteredRecipes.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio:
                                      0.8, // Adjust based on design preference
                                  mainAxisExtent: height * 0.25,
                                ),
                            itemBuilder: (context, index) {
                              var recipe = controller.filteredRecipes[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    RoutsNames.recipeDetails,
                                    arguments: recipe,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                        bottom: Radius.circular(12),
                                      ),
                                      child:
                                          recipe.recipeImageUrl.isNotEmpty
                                              ? Hero(
                                                tag: recipe.recipeImageUrl,
                                                child: Image.memory(
                                                  recipe.recipeImageUrl,
                                                  height: height * 0.18,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                              : Container(
                                                height: height * 0.18,
                                                width: double.infinity,
                                                color:
                                                    Colors
                                                        .grey[300], // Placeholder if no image
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                    ),
                                    SizedBox(height: 5),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        recipe.recipeName,
                                        style: CustomStyle.titleMediumTextStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        "${recipe.category} • ${recipe.cookingTime} min",
                                        style: CustomStyle.smallGreyTextStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutsNames.addRecipe);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
