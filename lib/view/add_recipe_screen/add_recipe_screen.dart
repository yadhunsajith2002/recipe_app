import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/controller/add_recipe_controller.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';

class RecipeCreationScreen extends GetView<RecipeController> {
  const RecipeCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var headingStyle = CustomStyle.titleMediumTextStyle.copyWith(
      color: ColorCode.mainColor,
      fontSize: 22,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Recipe", style: CustomStyle.titleLargeTextStyle),
        backgroundColor: ColorCode.mainColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recipe Name", style: headingStyle),

            SizedBox(height: 10),
            TextField(
              controller: controller.recipeNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Recipe Category", style: headingStyle),
            SizedBox(height: 10),
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedCategory.value,
                items:
                    controller.recipeCategories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setSelectedCategory(value);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Text("Ingredients", style: headingStyle),
            Obx(
              () => Column(
                children: List.generate(controller.ingredients.length, (index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.ingredients[index],
                            decoration: InputDecoration(
                              hintText: "Ingredient",
                              hintStyle: GoogleFonts.aBeeZee(
                                color: Colors.grey.shade600,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => controller.removeIngredient(index),
                      ),
                    ],
                  );
                }),
              ),
            ),
            TextButton(
              onPressed: controller.addIngredient,
              child: Row(children: [Icon(Icons.add), Text("Add Ingredient")]),
            ),

            SizedBox(height: 10),
            Text("Instructions", style: headingStyle),
            Obx(
              () => Column(
                children: List.generate(controller.instructions.length, (
                  index,
                ) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller.instructions[index],
                            decoration: InputDecoration(
                              hintText: "Steps",
                              hintStyle: GoogleFonts.aBeeZee(
                                color: Colors.grey.shade600,
                              ),
                              border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => controller.removeInstruction(index),
                      ),
                    ],
                  );
                }),
              ),
            ),
            TextButton(
              onPressed: controller.addInstruction,
              child: Row(children: [Icon(Icons.add), Text("Add Ingredient")]),
            ),

            SizedBox(height: 10),
            Text("Cooking Time (Minutes)", style: headingStyle),
            SizedBox(height: 10),
            TextField(
              controller: controller.cookingTimeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            SizedBox(height: 10),
            Text("Upload Image", style: headingStyle),
            SizedBox(height: 10),
            Obx(
              () =>
                  controller.selectedImage.value == null
                      ? Text("No image selected")
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          controller.selectedImage.value!,
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorCode.mainColor,
                  ),
                  onPressed: () => controller.pickImage(ImageSource.camera),
                  child: Text("Camera"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => controller.pickImage(ImageSource.gallery),
                  child: Text("Gallery"),
                ),
              ],
            ),

            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorCode.mainColor,
                ),
                onPressed: controller.submitRecipe,
                child: Text(
                  "Submit Recipe",
                  style: GoogleFonts.aBeeZee(
                    color: ColorCode.kwhite,
                    fontSize: 20, // Increased font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
