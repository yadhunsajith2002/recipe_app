import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/view/favorite_screen/favorite_screen.dart';
import 'package:recipe_app/view/home_screen/home_screen.dart';
import 'package:recipe_app/view/profile_screen/profile_screen.dart';

import '../router/routs_names.dart';

import 'controller_bindings.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var navigationId = Random().nextInt(100000);
  final pages = <String>[
    RoutsNames.home,
    RoutsNames.favorites,
    RoutsNames.profile,
  ];

  void selectScreen(int index) {
    selectedIndex.value = index;
    debugPrint("changeTabIndex : $index");
    debugPrint("navigationId : $navigationId");
    Get.toNamed(pages[index], id: navigationId);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RoutsNames.home) {
      return GetPageRoute(
        settings: settings,
        page: () => HomeScreen(),
        binding: HomeControllerBinding(),
        transition: Transition.noTransition,
      );
    } else if (settings.name == RoutsNames.favorites) {
      return GetPageRoute(
        settings: settings,
        page: () => FavoritePage(),
        binding: FavoriteControllerBinding(),
        transition: Transition.noTransition,
      );
    } else if (settings.name == RoutsNames.profile) {
      return GetPageRoute(
        settings: settings,
        page: () => ProfileScreen(),
        binding: ProfileControllerBinding(),
        transition: Transition.noTransition,
      );
    }
    return null;
  }
}
