import 'package:flutter/cupertino.dart';

class Unit {

  static late final BuildContext context;
  static late final double? baseWidth;
  static late final double? baseHeight;

  static init({required BuildContext context, double? baseWidth, double? baseHeight}) {
    Unit.context = context;
    Unit.baseWidth = baseWidth;
    Unit.baseHeight = baseHeight;
  }

  static double get getWidthSize => MediaQuery.sizeOf(context).width;

  static double get getHeightSize => MediaQuery.sizeOf(context).height;

  static double screenWidth(double ratio) {
    assert(ratio >= 0 && ratio <= 100, 'Ratio must be between 0 and 100');
    return ratio * getWidthSize / 100;
  }

  static double screenHeight(double ratio) {
    assert(ratio >= 0 && ratio <= 100, 'Ratio must be between 0 and 100');
    return ratio * getHeightSize / 100;
  }

  static double width(double pixels) => (pixels / (baseWidth??getWidthSize)) * getWidthSize;

  static double height(double pixels) => (pixels / (baseHeight??getHeightSize)) * getHeightSize;

  static double iconSize(double pixels) => ( width(pixels) + height(pixels) ) / 2;

  static double fontSize(double pixels) => ( width(pixels) + height(pixels) ) / 2;
}
