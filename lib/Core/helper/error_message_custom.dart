import 'package:flutter/material.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';


class ErrorMessageCustom extends StatelessWidget {
  final String message;
  const ErrorMessageCustom({Key? key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: ColorData.dangerColor,
            size: Unit.getWidthSize * 0.042,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Text(message,style: StyleData.textStyleDanger75R12,),
          ),
        ],
      ),
    );
  }
}