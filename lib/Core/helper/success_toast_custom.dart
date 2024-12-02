import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';

showSuccessToast({required String message}){
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: ColorData.successColor,
    gravity: ToastGravity.TOP,
    fontSize: Unit.getWidthSize * 0.045,
    textColor: ColorData.whiteColor,
  );
}

