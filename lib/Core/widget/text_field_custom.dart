import 'package:flutter/material.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final dynamic iconData;
  final FormFieldValidator? validator;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Function(dynamic p0)? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? autofocus;
  final Color? borderColor;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextStyle? hintStyle;

  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.iconData,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.onChanged,
    this.autofocus,
    this.borderColor,
    this.textInputAction,
    this.cursorColor,
    this.style,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.done,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus ?? false,
      onChanged: onChanged,
      controller: controller,
      cursorColor: cursorColor ?? ColorData.primaryColor,
      style: style ?? StyleData.textStyleWhiteR16,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      onTapOutside: (e) => FocusManager.instance.primaryFocus!.unfocus(),
      decoration: InputDecoration(
        filled: false,
        hintText: hintText,
        hintStyle: hintStyle ?? StyleData.textStyleWhiteR16,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorData.primary25Color, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorData.primaryColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorData.dangerColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorData.danger50Color, width: 2),
        ),
      ),
    );
  }
}