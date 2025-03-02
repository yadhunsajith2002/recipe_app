import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class StaticData {
  static String apiBaseUrl = "";
  static String version = "1.0.0";
  static String defaultPlaceHolder = "assets/app_logo/app_logo.png";
  static bool appInDevelopment = !isProduction;
  static String currentDateFormat = "dd/MM/yyyy";

  static List<Color> vehicleColors = [
    Colors.white,
    Colors.grey,
    Colors.black,
    Colors.red,
    Colors.blue,
    const Color(0xffCEB795),
  ];
  static List<String> vehicleColorsString = [
    "White",
    "Grey",
    "Black",
    "Red",
    "Blue",
    "Brown",
  ];

  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyCwagbcmQEzdXdBK0p-4lu75FS2tJxFhu4",
          authDomain: "car-valet-ae909.firebaseapp.com",
          projectId: "car-valet-ae909",
          storageBucket: "car-valet-ae909.appspot.com",
          messagingSenderId: "947884516786",
          appId: "1:947884516786:web:ecf5a282c8619b3815b0ab",
          measurementId: "G-07NW1S0B0W");
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          apiKey: "AIzaSyD0-0XcOG_gcuIFdmnNbUP3QnUM9clrkb0",
          authDomain: "test.firebaseapp.com",
          projectId: "test",
          storageBucket: "test.appspot.com",
          messagingSenderId: "942082737300",
          appId: "1:942082737300:android:96f3b3597e03b9023fa081",
          measurementId: "G-SM0YJNF337",
          iosBundleId: 'com.garage',
          iosClientId: '942082737300-3e41dal91j9ccogun8te3m5611s3qtou.apps.googleusercontent.com');
    } else {
      // Android
      return const FirebaseOptions(
          apiKey: "AIzaSyDQE29pDETdyxAC9XaTRhTFfaaet9ikbw4",
          authDomain: "car-valet-ae909.firebaseapp.com",
          projectId: "car-valet-ae909",
          storageBucket: "car-valet-ae909.appspot.com",
          messagingSenderId: "947884516786",
          appId: "1:947884516786:android:f13c5380bba3894515b0ab",
          measurementId: "G-07NW1S0B0W");
    }
  }


}

enum DeviceType { android, web, ios }
