import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:khatwa_client/Core/helper/loading_custom.dart';
import 'package:khatwa_client/Core/services/launch_services.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Feather/Setting/presentation/cubit/setting_cubit.dart';
import 'package:khatwa_client/Feather/Setting/presentation/cubit/setting_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    super.initState();
    SettingCubit.get(context).getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit,SettingState>(
      builder: (context, state) {
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(SettingState is GetBannersLoading)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 225.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                    items: [
                      for(int i = 0; i < 3; i++)...[
                        Builder(
                          builder: (BuildContext context) {
                            return  Container(
                              width:
                              MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: ColorData.primary75Color,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: LoadingCustom(),
                              ),
                            );
                          },
                        )
                      ]
                    ],
                  ),
                ),
              ),

            if(SettingCubit.get(context).showAds && !(SettingState is GetBannersLoading))
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 225.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                    items: SettingCubit.get(context).adsModel.ads?.map((ad) {
                      return Builder(
                        builder: (BuildContext context) {
                          return  Container(
                            width:
                            MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ColorData.primary75Color,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.network(
                              ad.image??'',
                              fit: BoxFit.fill,


                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

            if(SettingCubit.get(context).showAds && !(SettingState is GetBannersLoading))
              Divider(
                indent: 12,
                endIndent: 12,
              ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'بعض الارشادات',
                style: StyleData.textStyleBlackB32,
              ),
            ) ,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "لا تنسى تقييم السائق ورأيك به",
                    style: StyleData.textStyleBlackM18,
                  ),
                  Gap(8),
                  Text(
                    "في حالة وجود اى مشكلة يمكنك التواصل معنا",
                    style: StyleData.textStyleBlackM18,
                  ),
                ],
              ),
            ),

            Gap(8),
            Divider(
              indent: 12,
              endIndent: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'تواصل معنا',
                style: StyleData.textStyleBlackB32,
              ),
            ) ,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size: 40,),
                  onPressed: () => launchLink(ConstantData.kFacebookURL),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink,size: 40,),
                  onPressed: () => launchLink(ConstantData.kInstagramURL),
                ),

                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,size: 40,),
                  onPressed: () => launchLink(ConstantData.kWhatsappURL),
                ),
              ],

            ),

          ],
        );
      },
    );


  }
}
