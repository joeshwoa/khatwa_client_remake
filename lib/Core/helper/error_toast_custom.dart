import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';

showErrorToast({required String message}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: ColorData.dangerColor,
    gravity: ToastGravity.TOP,
    fontSize: Unit.getWidthSize * 0.045,
    textColor: ColorData.whiteColor,
  );
}