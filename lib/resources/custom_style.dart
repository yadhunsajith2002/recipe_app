import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_code.dart';

class CustomStyle {
  static var titleLargeTextStyle = GoogleFonts.aBeeZee(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: ColorCode.kwhite,
  );
  static var titleMediumTextStyle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorCode.kwhite,
  );
  static var titleSmallTextStyle = GoogleFonts.aBeeZee(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: ColorCode.kwhite,
  );
  static var hintTextStyle = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: ColorCode.kgreyshade800,
  );
  static var smallGreyTextStyle = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorCode.kgreyshade800,
  );
  static var emptyListTextStyle = GoogleFonts.lato(
    fontSize: 22,
    fontWeight: FontWeight.w300,
    color: ColorCode.kgreyshade800,
  );
}
