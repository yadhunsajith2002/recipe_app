import 'package:get/get.dart';
import 'package:recipe_app/controller/controller_bindings.dart';
import 'package:recipe_app/router/routs_names.dart';
import 'package:recipe_app/view/add_recipe_screen/add_recipe_screen.dart';
import 'package:recipe_app/view/favorite_screen/favorite_screen.dart';
import 'package:recipe_app/view/home_screen/home_screen.dart';
import 'package:recipe_app/view/login_screen/login_screen.dart';
import 'package:recipe_app/view/main_screen/main_screen.dart';
import 'package:recipe_app/view/user_recipe_screen/user_recipe_screen.dart';
import 'package:recipe_app/view/profile_screen/profile_screen.dart';
import 'package:recipe_app/view/recipe_details_screen/recipe_details_screen.dart';
import 'package:recipe_app/view/register_screen/register_screen.dart';
import 'package:recipe_app/view/splash_screen/splash_screen.dart';

class AppRoutes {
  // need to change the initial route
  static const initial = RoutsNames.launcher;

  static final routes = [
    GetPage(
      page: () => SplashScreen(),
      bindings: [SplashControllerBinding()],
      name: RoutsNames.launcher,
    ),
    GetPage(
      page: () => const RegisterScreen(),
      bindings: [AuthControllerBinding()],
      name: RoutsNames.register,
    ),
    GetPage(
      page: () => const LoginScreen(),
      bindings: [AuthControllerBinding()],
      name: RoutsNames.login,
    ),
    GetPage(
      page: () => HomeScreen(),
      bindings: [HomeControllerBinding()],
      name: RoutsNames.home,
    ),
    GetPage(
      page: () => MainScreen(),
      bindings: [MainScreenControllerBinding()],
      name: RoutsNames.main,
    ),
    GetPage(
      page: () => RecipeCreationScreen(),
      bindings: [AddRecipeControllerBinding()],
      name: RoutsNames.addRecipe,
    ),
    GetPage(
      page: () => RecipeDetailsPage(),
      bindings: [RecipeDetailsControllerBinding()],
      name: RoutsNames.recipeDetails,
    ),
    GetPage(
      page: () => FavoritePage(),
      bindings: [FavoriteControllerBinding()],
      name: RoutsNames.favorites,
    ),
    GetPage(
      page: () => ProfileScreen(),
      bindings: [ProfileControllerBinding()],
      name: RoutsNames.profile,
    ),
    GetPage(
      page: () => UserRecipesScreen(),
      bindings: [UserRecipeControllerBinding()],
      name: RoutsNames.userRecipes,
    ),
  ];
}
