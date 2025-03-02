import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:recipe_app/controller/main_controller.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/resources/custom_style.dart';
import 'package:recipe_app/router/routs_names.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(controller.navigationId),
        initialRoute: RoutsNames.home,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Obx(
          () => BottomNavigationBar(
            unselectedLabelStyle: CustomStyle.titleSmallTextStyle,
            selectedLabelStyle: CustomStyle.titleSmallTextStyle,
            selectedItemColor: ColorCode.mainColor,
            selectedIconTheme: const IconThemeData(color: ColorCode.mainColor),
            currentIndex: controller.selectedIndex.value,
            onTap: (value) {
              controller.selectScreen(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 0
                      ? Icons.home
                      : Icons.home_outlined,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 1
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                ),
                label: "favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 2
                      ? Icons.person
                      : Icons.person_2_outlined,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
