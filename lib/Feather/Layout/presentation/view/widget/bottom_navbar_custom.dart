import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:khatwa_client/Feather/Layout/presentation/cubit/layout_cubit.dart';

class BottomNavbarCustom extends StatefulWidget {
  final Function(int) onChangePage;
  final Color barBackgroundColor;
  final Color itemBorderTopColor;
  final Color? itemShadowTopGradientColor;
  final Curve curveOn;
  final Curve curveOff;
  final BorderRadiusGeometry? borderRadius;
  final Duration durationAnimation;
  final List<NavigationBarItemCustom> items;
  final int startIndex;
  const BottomNavbarCustom({
    super.key,
    required this.onChangePage,
    required this.items,
    this.barBackgroundColor = Colors.black,
    this.borderRadius,
    this.curveOn = Curves.bounceIn,
    this.curveOff = Curves.easeOut,
    this.durationAnimation = const Duration(milliseconds: 600),
    this.itemBorderTopColor = Colors.green,
    this.startIndex = 0,
    this.itemShadowTopGradientColor});

  @override
  State<BottomNavbarCustom> createState() => _BottomNavbarCustomState();
}

class _BottomNavbarCustomState extends State<BottomNavbarCustom> {

  int itemIndex = 0;

  @override
  void initState() {
    itemIndex = widget.startIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
          color: widget.barBackgroundColor,
          borderRadius: widget.borderRadius??BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(widget.items.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  LayoutCubit.get(context).screenIndex = index;
                  widget.onChangePage(index);
                });
              },
              child: AnimatedContainer(
                curve: index == LayoutCubit.get(context).screenIndex ? widget.curveOn : widget.curveOff,
                duration: widget.durationAnimation,
                width: 75,
                height: 75,
                child: index == LayoutCubit.get(context).screenIndex ? widget.items[index].selectedChild : widget.items[index].unselectedChild,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: index == LayoutCubit.get(context).screenIndex ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.itemShadowTopGradientColor ?? Colors.green.shade700.withOpacity(0.5),
                        Colors.white,
                        Colors.white
                      ]
                  ) : null,
                  border: Border(
                      top: BorderSide(
                          color: index == LayoutCubit.get(context).screenIndex ? widget.itemBorderTopColor : Colors.grey,
                          width: index == LayoutCubit.get(context).screenIndex ? 5 : 3
                      )
                  ),
                ),
              ),
            );
          },),
        ],
      ),
    );
  }
}

class NavigationBarItemCustom {
  final Widget unselectedChild;
  final Widget selectedChild;

  NavigationBarItemCustom({
    required this.selectedChild,
    required this.unselectedChild,
  });
}
