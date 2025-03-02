import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/resources/color_code.dart';

import '../utils/static_data.dart';

Widget customCard({
  required Widget child,
  required double radius,
  required double blurRadius,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: blurRadius,
        ),
      ],
    ),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    ),
  );
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
    return NetworkImage(Uri.encodeFull(url));
  }
  if (StaticData.defaultPlaceHolder.startsWith("http")) {
    return NetworkImage(StaticData.defaultPlaceHolder);
  }
  return AssetImage(StaticData.defaultPlaceHolder);
}

Widget getPlaceHolder() {
  if (StaticData.defaultPlaceHolder.startsWith("http")) {
    return Image.network(StaticData.defaultPlaceHolder);
  }
  return Image.asset(StaticData.defaultPlaceHolder);
}

Widget appTitle() {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Green ",
          style: GoogleFonts.moonDance(
            fontSize: 36,
            color: ColorCode.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: "Plate",
          style: GoogleFonts.moonDance(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
