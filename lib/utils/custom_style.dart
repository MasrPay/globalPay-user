import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
//------------------------dark--------------------------------
  static var darkHeading1TextStyle = GoogleFonts.cairo(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading2TextStyle = GoogleFonts.cairo(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading3TextStyle = GoogleFonts.cairo(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading4TextStyle = GoogleFonts.cairo(
    color: CustomColor.whiteColor.withOpacity(
      0.6,
    ),
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var darkHeading5TextStyle = GoogleFonts.cairo(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

//------------------------light--------------------------------
  static var lightHeading1TextStyle = GoogleFonts.cairo(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading2TextStyle = GoogleFonts.cairo(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading3TextStyle = GoogleFonts.cairo(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading4TextStyle = GoogleFonts.cairo(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var lightHeading5TextStyle = GoogleFonts.cairo(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

  static var screenGradientBG2 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
        CustomColor.primaryDarkColor,
        CustomColor.primaryBGDarkColor,
      ]));

  static var onboardTitleStyle = GoogleFonts.cairo(
      textStyle: TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w900,
  ));

  static var onboardSubTitleStyle = GoogleFonts.cairo(
      textStyle: TextStyle(
    color: CustomColor.primaryTextColor.withOpacity(0.6),
    fontSize: Dimensions.headingTextSize4 * 0.9,
    fontWeight: FontWeight.w400,
  ));

  static var onboardSkipStyle = GoogleFonts.cairo(
      textStyle: TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w500,
  ));
  static var signInInfoTitleStyle = GoogleFonts.cairo(
      textStyle: TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  ));
  static var signInInfoSubTitleStyle = GoogleFonts.cairo(
      textStyle: TextStyle(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  ));
  static var f20w600pri = GoogleFonts.cairo(
      textStyle: GoogleFonts.cairo(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w600,
  ));
  static var labelTextStyle = GoogleFonts.cairo(
      textStyle: GoogleFonts.cairo(
    fontWeight: FontWeight.w600,
    color: CustomColor.primaryLightColor,
    fontSize: Dimensions.headingTextSize4,
  ));

  static var whiteTextStyle = TextStyle(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w500,
  );

  static var statusTextStyle = TextStyle(
    fontSize: Dimensions.headingTextSize6,
    fontWeight: FontWeight.w600,
  );

  static var yellowTextStyle = TextStyle(
    color: CustomColor.yellowColor,
    fontSize: Dimensions.headingTextSize6,
    fontWeight: FontWeight.w600,
  );
}
