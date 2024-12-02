import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';

showToast({required String message}){
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: ColorData.primaryColor,
    gravity: ToastGravity.TOP,
    fontSize: Unit.getWidthSize * 0.045,
    textColor: ColorData.whiteColor,
  );
}