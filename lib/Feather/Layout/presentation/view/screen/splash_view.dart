import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatwa_client/Core/services/shared_pref_services.dart';
import 'package:khatwa_client/Core/unit/app_routes.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';
import 'package:khatwa_client/Feather/Auth/data/model/user_model.dart';
import 'package:khatwa_client/Feather/Auth/presentation/cubit/auth_cubit.dart';
import 'package:khatwa_client/generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      final String token = SharedPreferencesServices.getData(key: ConstantData.kUser)??'';
      if (token.isEmpty) {
        context.go(AppRouter.kLoginView);
      } else {
        AuthCubit.get(context).userModel = UserModel.fromJson(jsonDecode(SharedPreferencesServices.getData(key: ConstantData.kUser)));
        context.go(AppRouter.kLayoutView);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2,tileMode: TileMode.decal),
              child: Image(
                image: AssetImage(Assets.imagesBackgroundGarage),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: ColorData.primaryColor.withOpacity(0.7),
            ),
            Image(
              image: AssetImage(Assets.imagesAppNameLogo),
              width: Unit.screenWidth(80),
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
