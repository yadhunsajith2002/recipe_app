import 'dart:math';

import 'package:flutter/material.dart';

/// ************************************ Firebase Storage ************************************************/
const folderUserProfile = 'user_profiles';
const folderRecipeImages = 'recipe_images';

/// ************************************ Firebase Tables ************************************************/
const tableUsers = 'users';
const tableRecipes = 'recipes';
const tableFavorites = 'favorites';
const tableComments = 'comments';
const tableRatings = 'ratings';

/// ************************************ Firebase Keys ************************************************/

// User Authentication
const keyUserId = 'user_id';
const keyEmail = 'email';
const keyPassword = 'password';
const keyUserName = 'username';
const keyProfilePicture = 'profile_picture';
const keyCreatedAt = 'created_at';
const keyUpdatedAt = 'updated_at';
const keyAccountStatus = 'account_status';

// Recipe Details
const keyRecipeId = 'recipe_id';
const keyRecipeName = 'recipe_name';
const keyIngredients = 'ingredients';
const keyInstructions = 'instructions';
const keyCookingTime = 'cooking_time';
const keyServings = 'servings';
const keyRecipeImage = 'recipe_image';
const keyCategory = 'category';
const keyCreatedBy = 'created_by';
const keyCreatedByName = 'created_by_name';

// Favorites & User Collection
const keyFavoriteRecipes = 'favorite_recipes';

// Community Interaction
const keyComments = 'comments';
const keyRatings = 'ratings';
const keyReviewText = 'review_text';
const keyStarRating = 'star_rating';

/// ************************************ Firebase Values ************************************************/
const categoryAppetizers = 'Appetizers';
const categoryMainCourses = 'Main Courses';
const categoryDesserts = 'Desserts';
const categoryDrinks = 'Drinks';
const categorySnacks = 'Snacks';

/// ************************************ Firebase Value ************************************************/

const userRoleAdmin = 'admin';
const userRoleDrive = 'driver';
const userRoleMember = 'member';
const userRoleGuest = 'guest';
const accountAllowed = 'allowed';
const accountBlocked = 'blocked';

/// ************************************ Shared-Preference Keys ************************************************/
const prefIsLoggedIn = "is_logged_in";
const prefUserId = 'user_id';
const prefUserName = 'username';
const prefEmail = 'email';
const prefProfilePicture = 'profile_picture';
const prefFavoriteRecipes = 'favorite_recipes';
const prefPassword = 'password';
const prefRemember = 'remember';

/// ************************************ Status Codes ************************************************/
const statusSuccess = 200;
const statusFailed = 417;
const statusNotFound = 404;
const onSuccess = 200;
const onFailed = 417;
const onNotFound = 404;

/// ************************************ Utility Functions ************************************************/
String generateOTP({required int digits}) {
  Random random = Random();
  return List.generate(digits, (index) => random.nextInt(10).toString()).join();
}

// default String generateRandomString({required int length}) {
//   const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#%^&*()_+=-/';
//   Random random = Random();
//   return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
// }
