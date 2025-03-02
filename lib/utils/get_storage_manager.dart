import 'package:get_storage/get_storage.dart';

class GetStorageManager {
  static String storageName = "user_data";
  static GetStorage? _getStorage;

  //############Get values################

  static dynamic getValue(String key, dynamic defaultValue) {
    _getStorage ??= GetStorage(storageName);
    return _getStorage!.read(key) ?? defaultValue;
  }

  //############Set values################

  static void setValue(String key, dynamic defaultValue) {
    _getStorage ??= GetStorage(storageName);
    _getStorage!.write(key, defaultValue);
  }

  //############ Remove value by key ################
  static void removeValue(String key) {
    _getStorage ??= GetStorage(storageName);
    _getStorage!.remove(key);
  }

  //############ Clear Preference ################
  static void clear() {
    _getStorage ??= GetStorage(storageName);
    _getStorage!.erase();
  }
}
