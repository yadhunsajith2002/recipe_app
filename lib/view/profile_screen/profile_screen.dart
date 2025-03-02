import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/main_controller.dart';
import 'package:recipe_app/controller/profile_controller.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/router/routs_names.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';
import 'package:recipe_app/utils/utils_methods.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    final mainController = Get.find<MainController>();
    return Scaffold(
      body: ListView(
        children: [
          // Profile Header
          Column(
            children: [
              SizedBox(height: 20),
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child:
                      controller.profileImageBytes.value != null
                          ? Image.memory(
                            controller.profileImageBytes.value!,
                            height: height * 0.15,
                            width: width * 0.15,
                            fit: BoxFit.cover,
                          )
                          : Container(
                            height: height * 0.15,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                GetStorageManager.getValue(
                  prefEmail,
                  "",
                ).split('@').first.toString().firstCapitalize(),
                style: CustomStyle.titleLargeTextStyle,
              ),
              Text(
                GetStorageManager.getValue(prefEmail, ""),
                style: CustomStyle.titleMediumTextStyle.copyWith(
                  color: ColorCode.kgrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),

          // Profile Options
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // padding: EdgeInsets.all(20),
              children: [
                buildProfileOption(
                  icon: Icons.person,
                  title: "My Recipes",
                  onTap: () {
                    Get.toNamed(RoutsNames.userRecipes);
                  },
                ),
                buildProfileOption(
                  icon: Icons.bookmark,
                  title: "Favorite recipes",
                  onTap: () {
                    mainController.selectScreen(1);
                  },
                ),
                buildProfileOption(icon: Icons.settings, title: "Settings"),
                buildProfileOption(
                  icon: Icons.group_add,
                  title: "Invite Friends",
                ),
                SizedBox(height: 20),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logoutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCode.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: CustomStyle.titleMediumTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption({
    required IconData icon,
    required String title,
    void Function()? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: CustomStyle.titleMediumTextStyle),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
