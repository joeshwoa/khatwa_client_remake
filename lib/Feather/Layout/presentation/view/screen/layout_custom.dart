import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';
import 'package:khatwa_client/Feather/Layout/presentation/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Feather/Layout/presentation/view/widget/bottom_navbar_custom.dart';


class LayoutCustom extends StatelessWidget {
  const LayoutCustom({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Material(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  appBar: AppBar(
                    backgroundColor: ColorData.primary75Color,
                    title: LayoutCubit.get(context).appBars[LayoutCubit.get(context).screenIndex],
                    titleTextStyle: StyleData.textStyleWhiteSB30,
                    titleSpacing:40 ,
                  ),
                  bottomNavigationBar:BottomNavbarCustom(
                    barBackgroundColor: Colors.white,
                    itemBorderTopColor:  ColorData.primary75Color,
                    itemShadowTopGradientColor: Colors.deepOrange.shade800.withOpacity(0.6),
                    durationAnimation: Duration(milliseconds: 600),
                    onChangePage: (pageIndex) {
                      LayoutCubit.get(context).changePage(pageIndex);
                    },
                    items: [
                      NavigationBarItemCustom(
                          selectedChild: Icon(
                            Icons.home_rounded,
                            color: ColorData.primary75Color,
                            size: 30,
                          ),
                          unselectedChild: Icon(
                            Icons.home_outlined,
                            color: Colors.grey.shade600,
                            size: 30,
                          )
                      ),
                      NavigationBarItemCustom(
                          selectedChild: Icon(
                            Icons.receipt,
                            color: ColorData.primary75Color,
                            size: 30,
                          ),
                          unselectedChild: Icon(
                            Icons.receipt_outlined,
                            color: Colors.grey.shade600,
                            size: 30,
                          )
                      ),
                      NavigationBarItemCustom(
                          selectedChild: Icon(
                            Icons.more_horiz,
                            color: ColorData.primary75Color,
                            size: 30,
                          ),
                          unselectedChild: Icon(
                            Icons.more_horiz_outlined,
                            color: Colors.grey.shade600,
                            size: 30,
                          )
                      ),
                      NavigationBarItemCustom(
                          selectedChild: Icon(
                            Icons.person,
                            color: ColorData.primary75Color,
                            size: 30,
                          ),
                          unselectedChild: Icon(
                            Icons.person_outline,
                            color: Colors.grey.shade600,
                            size: 30,
                          )
                      ),
                    ],
                  ) ,
                  body: LayoutCubit.get(context).pages[LayoutCubit.get(context).screenIndex],
                ),
                if(LayoutCubit.get(context).showBottomSheetElevationLayer) GestureDetector(
                  child: Container(
                    width: Unit.getWidthSize,
                    height: Unit.getHeightSize,
                    color: ColorData.blackColor.withOpacity(0.3),
                  ),
                ),
                LayoutCubit.get(context).builder(context)
              ],
            ),
          ),
        );
      },
    );
  }
}
