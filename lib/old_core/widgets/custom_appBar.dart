import 'package:flutter/material.dart';
import '../../features/home/views/mytrips.dart';
import '../helper/notifictions_helper.dart';
import 'custom_image.dart';
import 'responsive_text.dart';

import '../functions/global_function.dart';
import '../rescourcs/app_colors.dart';

PreferredSize customAppBarForSearch(context,
    {void Function()? onTap, void Function(String)? onChanged}) {
  final controller = TextEditingController();
  return PreferredSize(
    preferredSize: const Size.fromHeight(150),
    child: Container(
      width: screenSize(context).width,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 50),

              Image.asset(
                'assets/logo2.jpeg',
                height: 80,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Visibility(
            visible: true, // sharedPreferences.getBool(isDriver) ?? false,
            child: Positioned(
              bottom: 5,
              left: 5,
              child: InkWell(
                onTap:(){
                  navigateTo(const MyTrips());
                },// () =>// () => navigateTo(const OrdersView()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ResponsiveText(
                      text: 'الرحلات',
                      scaleFactor: .03,
                      color: AppColors.white,
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomAssetsImage(
                              path: 'assets/Uber Taxi.png',
                            ),
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: FirebaseMessagingService.not,
                            builder: (context,AsyncSnapshot<int> snapshot) {
                              print("notifications ${snapshot.data}");
                              if(snapshot.hasData){
                                return CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 8,
                                  child: ResponsiveText(
                                    text: '${snapshot.data}',
                                    scaleFactor: .02,
                                    color: AppColors.white,
                                  ),
                                );
                              }else if(snapshot.hasError){
                                return Container();
                              }else{
                                return Container();
                              }

                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

PreferredSize customAppBar(context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(70),
    child: SafeArea(
      child: Container(
        width: screenSize(context).width,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo2.jpeg',
                height: 70,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
