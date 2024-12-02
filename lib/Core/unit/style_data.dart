import 'package:flutter/material.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/font_weiget_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';


class StyleData {
  static late final BuildContext context;
  static late final String fontFamily;

  static init({required BuildContext context,required String fontFamily}) {
    StyleData.context = context;
    StyleData.fontFamily = fontFamily;
  }



  static TextStyle textStylePrimaryB25 = TextStyle(
    color: ColorData.primaryColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: Unit.fontSize(25),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleWhiteR16 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.regular,
    fontSize: Unit.fontSize(16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteB36 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: Unit.fontSize(36),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteSB30 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: Unit.fontSize(30),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteSB20 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.semiBold,
    fontSize: Unit.fontSize(20),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteR14 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.regular,
    fontSize: Unit.fontSize(14),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteB18 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: Unit.fontSize(18),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleWhiteM14 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.medium,
    fontSize: Unit.fontSize(14),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleBlackR16 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.regular,
    fontSize: Unit.fontSize(16),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlackM18 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.medium,
    fontSize: Unit.fontSize(18),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlackB20 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: Unit.fontSize(20),
    height: 0.0,
    fontFamily: fontFamily,
  );
  static TextStyle textStyleBlackB32 = TextStyle(
    color: ColorData.blackColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: Unit.fontSize(32),
    height: 0.0,
    fontFamily: fontFamily,
  );

  static TextStyle textStyleDanger75R12 = TextStyle(
    color: ColorData.danger75Color,
    fontWeight: FontWeightStyles.regular,
    fontSize: Unit.fontSize(14),
    height: 0.0,
    fontFamily: fontFamily,
  );
}
