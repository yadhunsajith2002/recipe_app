import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/default_response.dart';
import '../resources/tables_keys_values.dart';

class FirebaseApi {
  late FirebaseFirestore fireStore;
  FirebaseApi() {
    fireStore = FirebaseFirestore.instance;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Register User with Email, Password & Profile Picture
  Future<DefaultResponse> registerUser({
    required String email,
    required String password,
    required File profileImage,
  }) async {
    DefaultResponse response = DefaultResponse();

    try {
      // ✅ Create user in Firebase Authentication
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // ✅ Upload profile image to Firebase Storage
      String base64Image = await convertImageToBase64(profileImage);

      // ✅ Save user details in Firestore
      Map<String, dynamic> userData = {
        keyEmail: email,
        keyProfilePicture: base64Image,
        "password": password, // 🔴 Storing password as plain text is not secure
        keyCreatedAt: DateTime.now().toIso8601String(),
      };

      await _firestore.collection(tableUsers).doc(uid).set(userData);

      response.status = true;
      response.statusCode = 200;
      response.message = "User registered successfully!";
    } catch (e) {
      response.status = false;
      response.statusCode = 500;
      response.message = "Error: ${e.toString()}";
    }

    return response;
  }

  /// ✅ Login User with Email & Password
  Future<DefaultResponse> loginUser({
    required String email,
    required String password,
  }) async {
    DefaultResponse defaultResponse = DefaultResponse();
    QuerySnapshot querySnapshot =
        await fireStore
            .collection(tableUsers)
            .where(keyEmail, isEqualTo: email)
            .get();

    if (querySnapshot.docs.isNotEmpty &&
        querySnapshot.docs[0].get(keyEmail) == email &&
        querySnapshot.docs[0].get(keyPassword) == password) {
      defaultResponse.statusCode = onSuccess;
      defaultResponse.status = true;
      defaultResponse.message = "User Login Successfully";
      defaultResponse.responseData = querySnapshot.docs[0];
    } else {
      defaultResponse.statusCode = onFailed;
      defaultResponse.status = false;
      defaultResponse.message = "Please enter valid email and password";
    }
    return defaultResponse;
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await FirebaseFirestore.instance
        .collection(tableUsers)
        .doc(uid)
        .get();
  }

  /// ✅ Get Logged-in User Details
  Future<DefaultResponse> getLoggedInUserDetails() async {
    DefaultResponse defaultResponse = DefaultResponse();
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot =
            await fireStore.collection(tableUsers).doc(user.uid).get();

        if (documentSnapshot.exists) {
          defaultResponse.statusCode = 200;
          defaultResponse.status = true;
          defaultResponse.responseData = documentSnapshot.data();
        } else {
          defaultResponse.statusCode = 404;
          defaultResponse.status = false;
          defaultResponse.message = "Driver not found";
        }
      } catch (e) {
        defaultResponse.statusCode = 500;
        defaultResponse.status = false;
        defaultResponse.message = e.toString();
      }
    } else {
      defaultResponse.statusCode = 401;
      defaultResponse.status = false;
      defaultResponse.message = "User not logged in";
    }

    return defaultResponse;
  }

  /// ✅ Add New Recipe to Firestore
  Future<DefaultResponse> addNewRecipe({
    required String recipeName,
    required List<String> ingredients,
    required List<String> instructions,
    required String cookingTime,
    required int servings,
    required String category,
    required File recipeImageUrl,
    required String createdByName,
  }) async {
    DefaultResponse response = DefaultResponse();
    User? user = _auth.currentUser;
    if (user == null) {
      response.status = false;
      response.statusCode = 401;
      response.message = "User not authenticated.";
      return response;
    }
    try {
      String base64Image = await convertImageToBase64(recipeImageUrl);
      // ✅ Generate a unique recipe ID
      String recipeId = _firestore.collection(tableRecipes).doc().id;

      // ✅ Create recipe data map
      Map<String, dynamic> recipeData = {
        keyRecipeId: recipeId,
        keyRecipeName: recipeName,
        keyIngredients: ingredients,
        keyInstructions: instructions,
        keyCookingTime: cookingTime,
        keyServings: servings,
        keyCategory: category,
        keyRecipeImage: base64Image,
        keyCreatedBy: user.uid, // Recipe created by the current user
        keyCreatedAt: DateTime.now().toIso8601String(),
        keyCreatedByName: createdByName,
      };

      // ✅ Store the recipe in Firestore
      await _firestore.collection(tableRecipes).doc(recipeId).set(recipeData);
      response.status = true;
      response.statusCode = statusSuccess;
      response.message = "Recipe added successfully!";
    } catch (e) {
      response.status = false;
      response.statusCode = statusFailed;
      response.message = "Error adding recipe: ${e.toString()}";
    }

    return response;
  }

  /// ✅ Logout User
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  /// ✅ Upload Profile Picture to Firebase Storage
  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}
