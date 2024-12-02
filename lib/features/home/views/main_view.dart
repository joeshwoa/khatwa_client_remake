import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../old_core/services/cache_storage_services.dart';
import '../../profile/controller/client_profile_controller.dart';
import '../../../old_core/helper/notifictions_helper.dart';
import '../../../old_core/rescourcs/app_colors.dart';
import '../../profile/presentation/view/client_profile_view.dart';
import 'home_view.dart';
import '../../setting/view/setting_view.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final profileController = Get.put(ClientProfileController());
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    print(CacheStorageServices().token);
    // TODO: implement initState
    Future(() async {
      await FirebaseMessagingService.initialize();
    });
    super.initState();
    FirebaseMessagingService.getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,

      backgroundColor: AppColors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      animationSettings: NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 200), curve: Curves.ease),
      ),
      // screenTransitionAnimation: const ScreenTransitionAnimation(
      //   // Screen transition animation on change of selected tab.
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return const [
      HomeView(),
      SettingView(),
      ClientProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("خطوة"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("الاعدادت"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("الملف الشخصي"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
