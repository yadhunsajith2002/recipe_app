import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/resources/color_code.dart';
import 'package:recipe_app/router/app_routes.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(GetStorageManager.storageName);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Recipe Management App",
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorCode.mainColor,
          surfaceTint: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
