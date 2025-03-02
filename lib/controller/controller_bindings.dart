import 'package:get/get.dart';
import 'package:recipe_app/controller/auth_controller.dart';
import 'package:recipe_app/controller/favorite_controller.dart';
import 'package:recipe_app/controller/home_controller.dart';
import 'package:recipe_app/controller/main_controller.dart';
import 'package:recipe_app/controller/add_recipe_controller.dart';
import 'package:recipe_app/controller/profile_controller.dart';
import 'package:recipe_app/controller/recipe_details_controller.dart';
import 'package:recipe_app/controller/splash_screen_controller.dart';
import 'package:recipe_app/controller/user_recipe_controller.dart';

class AuthControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class SplashControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class MainScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}

class AddRecipeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeController>(() => RecipeController());
  }
}

class RecipeDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeDetailsController>(() => RecipeDetailsController());
  }
}

class FavoriteControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}

class ProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class UserRecipeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRecipesController>(() => UserRecipesController());
  }
}
