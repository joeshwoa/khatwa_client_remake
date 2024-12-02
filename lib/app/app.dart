import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../binding.dart';
import '../old_core/rescourcs/app_colors.dart';
import '../old_core/rescourcs/app_theme.dart';
import '../features/auth/presentation/view/login_view.dart';
import '../features/home/views/home_view.dart';
import '../features/splash/presentation/splash.dart';
import '../features/home/views/main_view.dart';


class SeliveryClient extends StatelessWidget {
  const SeliveryClient({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      title: 'خطوة',
      theme: appTheme(),
      textDirection: TextDirection.rtl,
      home: SplashView(),
    );
  }
}
