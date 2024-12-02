import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';

class LoadingCustom extends StatelessWidget {

  final double size;
  const LoadingCustom({super.key, this.size = 65});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: LoadingAnimationWidget.waveDots(
          color: ColorData.primary75Color,
          size: size,
        ),
      ),
    );
  }
}
