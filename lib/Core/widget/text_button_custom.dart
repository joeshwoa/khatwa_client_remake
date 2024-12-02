import 'package:flutter/material.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/old_core/rescourcs/app_colors.dart';

class TextButtonCustom extends StatelessWidget {

  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final TextStyle? textStyle;

  const TextButtonCustom({super.key, required this.text, this.onTap, this.width, this.height, this.color, this.border, this.borderRadius, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color??AppColors.primaryColor,
          border: border??Border.all(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: borderRadius??BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle??StyleData.textStyleWhiteB18,
          ),
        ),
      ),
    );
  }
}
