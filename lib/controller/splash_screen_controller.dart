import 'package:get/get.dart';
import 'package:recipe_app/resources/tables_keys_values.dart';
import 'package:recipe_app/router/routs_names.dart';
import 'package:recipe_app/utils/get_storage_manager.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  /// ✅ Navigate to the appropriate screen after a delay
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading

    // ✅ Ensure GetStorageManager is initialized before accessing data

    bool isLoggedIn = GetStorageManager.getValue(prefIsLoggedIn, false);

    if (isLoggedIn) {
      Get.offAllNamed(RoutsNames.main); // Navigate to home if logged in
    } else {
      Get.offAllNamed(RoutsNames.login); // Navigate to login screen
    }
  }
}
