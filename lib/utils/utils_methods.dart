import 'dart:io' show Platform, exit;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:recipe_app/utils/app_snackbar.dart';
import 'package:recipe_app/utils/static_data.dart';
import 'package:recipe_app/utils/validation_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/custom_style.dart';
import '../resources/color_code.dart';
import '../resources/tables_keys_values.dart';
import '../router/routs_names.dart';
import 'get_storage_manager.dart';

/// *********************************** Responsive Font / Size *******************************
double getFontSize(double px) {
  Size size = Get.size;
  // Size size = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  num statusBar = Get.statusBarHeight;
  // num statusBar = WidgetsBinding.instance.platformDispatcher.views.first.viewPadding.top;
  num screenHeight = size.height - statusBar;
  final height = px * (screenHeight / 812);
  final width = px * (size.width / 375);
  // print("getFontSize : $width * $height");
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

bool checkRtl({required String currentLanguage}) {
  bool isRtl = false;
  if (currentLanguage == "ar" ||
      currentLanguage == "fa" ||
      currentLanguage == "ur") {
    isRtl = true;
  } else {
    isRtl = false;
  }
  return isRtl;
}

extension StringExtension on String {
  String firstCapitalize() {
    if (isEmpty) {
      return "";
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(" ").map((str) => str.inCaps).join(" ");
}

void logoutDialog() {
  Get.defaultDialog(
    title: "",
    content: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorCode.kYellow, ColorCode.kYellow],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.exit_to_app_rounded,
            color: ColorCode.mainColor,
            size: 35,
          ),
          // SvgPicture.asset('assets/images/Delate.svg'),
        ),
        const SizedBox(height: 40),
        Text(
          "Are you sure want to Logout?",
          style: CustomStyle.titleMediumTextStyle,
        ),
      ],
    ),
    cancel: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: ColorCode.kYellow, width: 2),
          gradient: const LinearGradient(
            colors: [ColorCode.kYellow, ColorCode.kYellow],
          ),
        ),
        child: Center(
          child: Text("Cancel", style: CustomStyle.titleMediumTextStyle),
        ),
      ),
    ),
    confirm: GestureDetector(
      onTap: () async {
        // var isRemember = GetStorageManager.getValue(prefRemember, false);
        // var email = GetStorageManager.getValue(prefEmail, "");
        // var pass = GetStorageManager.getValue(prefPassword, "");
        // GetStorageManager.clear();
        // if (isRemember) {
        //   GetStorageManager.setValue(prefEmail, email);
        //   GetStorageManager.setValue(prefPassword, pass);
        //   GetStorageManager.setValue(prefRemember, isRemember);
        // }
        // Get.offAllNamed(RoutsNames.launcher);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: ColorCode.kYellow, width: 2),
          gradient: const LinearGradient(
            colors: [ColorCode.kYellow, ColorCode.kYellow],
          ),
        ),
        child: Center(
          child: Text("Log out", style: CustomStyle.titleMediumTextStyle),
        ),
      ),
    ),
    titlePadding: EdgeInsets.zero,
  );
}

int getCurrentDateTime() {
  return DateTime.now().millisecondsSinceEpoch;
}

int getCurrentDateOnly() {
  var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return DateTime.parse(currentDate).millisecondsSinceEpoch;
}

int convertDateOnlyFromMilli(int milliSeconds) {
  var currentDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.fromMillisecondsSinceEpoch(milliSeconds));
  return DateTime.parse(currentDate).millisecondsSinceEpoch;
}

DateTime convertDateOnly(int milliSeconds) {
  var currentDate = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.fromMillisecondsSinceEpoch(milliSeconds));
  return DateTime.parse(currentDate);
}

/*Widget customMarquee({double height = 20, required double width, required String text, required TextStyle textStyle}) {
  return SizedBox(
    width: width,
    height: height,
    child: willTextOverflow(text: text, maxWidth: width, style: textStyle)
        ? Marquee(
            text: text,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 50.0,
            velocity: 20.0,
            pauseAfterRound: const Duration(seconds: 1),
            accelerationDuration: const Duration(seconds: 2),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 200),
            decelerationCurve: Curves.easeOut,
            style: textStyle)
        : Text(text, style: textStyle),
  );
}*/

bool willTextOverflow({
  required String text,
  required TextStyle style,
  required double maxWidth,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: ui.TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: maxWidth);

  return textPainter.didExceedMaxLines;
}

/*Widget customCacheImage({
  String? url,
  Uint8List? imageByte,
  BoxFit? fit,
  double? width,
  double? height,
  Widget? placeHolder,
}) {
  if (imageByte != null) {
    return Image.memory(imageByte, width: width, height: height, fit: fit);
  } else if (url != null && url != "") {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeHolder ?? Image.asset(StaticData.defaultPlaceHolder, width: width, height: height, fit: fit),
      errorWidget: (context, url, error) => placeHolder ?? Image.asset(StaticData.defaultPlaceHolder, width: width, height: height, fit: fit),
    );
  }
  return Image.asset(StaticData.defaultPlaceHolder, width: width, height: height, fit: fit);
}*/

/*Future<bool> openFilePermission() async {
  var status = await Permission.storage.status;
  if(Platform.isAndroid){
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var sdkInt = await deviceInfo.androidInfo;
    if (status.isGranted || (Platform.isAndroid && (sdkInt.version.sdkInt) >= 33)) {
      return true;
    } else {
      var permissionRequest = await Permission.storage.request();
      if (permissionRequest.isGranted) {
        return true;
      }
    }
  }
  else{
    var permissionRequest = await Permission.storage.request();
    if (permissionRequest.isGranted) {
      return true;
    }
  }

  return false;
}*/

Future<bool> showExitPopup(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey,
) async {
  var width = MediaQuery.of(context).size.width;
  bool opened = scaffoldKey.currentState!.isDrawerOpen;

  if (opened) {
    Navigator.pop(context);
    return false;
  }
  bool? isExit = await showGeneralDialog(
    context: context,
    barrierLabel: "Dietbux",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(5.0),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            "exit_app_message".tr,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins-Bold',
              color: Color(0xFF0B204C),
              fontSize: 17,
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorCode.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  if (Platform.isIOS) {
                    exit(0);
                  } else {
                    SystemNavigator.pop();
                  }
                },
                child: Text(
                  "yes".tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.05),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF26950),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "no".tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: Opacity(opacity: anim1.value, child: child),
      );
    },
  );
  if (isExit != null && isExit) {
    return isExit;
  } else {
    return false;
  }
}

ImageProvider customImageProvider({String? url, Uint8List? imageByte}) {
  if (imageByte != null) {
    debugPrint("url1 $url");
    return MemoryImage(imageByte);
  } else if (url != null && url != "" && url.startsWith("assets")) {
    debugPrint("url2 $url");
    return AssetImage(url);
  } else if (url != null && url != "") {
    debugPrint("url3 $url");
    return CachedNetworkImageProvider(url);
  }
  if (StaticData.defaultPlaceHolder.startsWith("http")) {
    return CachedNetworkImageProvider(StaticData.defaultPlaceHolder);
  }
  return AssetImage(StaticData.defaultPlaceHolder);
}

List<DateTime> getNext10Days() {
  List<DateTime> dates = [];
  DateTime today = DateTime.now();
  dates.add(today);
  for (int i = 0; i < 10; i++) {
    DateTime nextDay = today.add(Duration(days: i + 1));
    dates.add(nextDay);
  }
  return dates;
}

hideKeyboard() {
  debugPrint("Focus Mode hide");
  FocusManager.instance.primaryFocus?.unfocus();
  TextEditingController().clear();
}

dynamic getDocumentValue({
  required DocumentSnapshot? documentSnapshot,
  required String key,
  dynamic defaultValue = "",
}) {
  if (documentSnapshot != null &&
      documentSnapshot.exists &&
      (documentSnapshot.data() as Map<String, dynamic>).containsKey(key)) {
    return documentSnapshot[key];
  } else {
    return defaultValue;
  }
}

String getDatTimeString(int millisecond) {
  String timeString = '';
  DateTime today = DateTime.now();

  var dateOnly = convertDateOnly(millisecond);
  var hoursMin = DateFormat(
    'hh:mm a',
  ).format(DateTime.fromMillisecondsSinceEpoch(millisecond));
  if (today.isSameDate(dateOnly)) {
    timeString = "Today $hoursMin";
  } else if (today.add(const Duration(days: -1)).isSameDate(dateOnly)) {
    timeString = "Yesterday $hoursMin";
  } else {
    timeString = DateFormat(
      'dd-MM-yyyy hh:mm a',
    ).format(DateTime.fromMillisecondsSinceEpoch(millisecond));
  }
  return timeString;
}

void launchWhatsapp(String whatsapp) async {
  if (whatsapp.length == 10) {
    whatsapp = '91$whatsapp';
  }
  if (!whatsapp.startsWith("+")) {
    whatsapp = '+$whatsapp';
  }

  var whatsappAndroid = Uri.parse("https://wa.me/$whatsapp");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    AppSnackBar.error(message: "Whatsapp is not installed on the device");
  }
}

void makePhoneCall(String phone) async {
  try {
    if (phone.length == 10) {
      phone = '91$phone';
    }
    if (!phone.startsWith("+")) {
      phone = '+$phone';
    }
    var makeCall = Uri.parse("tel:$phone");
    if (await canLaunchUrl(makeCall)) {
      await launchUrl(makeCall);
    } else {
      AppSnackBar.error(message: "Phone call is not worked");
    }
  } catch (e) {
    debugPrint(e.toString());
    AppSnackBar.error(message: e.toString());
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
