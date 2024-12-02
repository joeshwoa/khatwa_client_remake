import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Feather/Activity/presentation/view/screen/activity_screen.dart';
import 'package:khatwa_client/Feather/Home/presentation/view/screen/home_screen.dart';
import 'package:khatwa_client/Feather/Profile/presentation/view/screen/profile_view.dart';
import 'package:khatwa_client/Feather/Setting/presentation/view/screen/setting_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);



  int screenIndex = 0;
  final List <Widget> appBars=[
    Text('الرئيسية'),
    Text('السجل'),
    Text('المزيد'),
    Text('الملف الشخصي'),
  ];
  final List<Widget> pages = [
    HomeScreen(),
    ActivityView(),
    SettingScreen(),
    ProfileView(),
  ];
  bool showBottomSheetElevationLayer = false;
  WidgetBuilder builder = (context) => IgnorePointer(child: SizedBox(height: 0,width: 0,));

  void changePage(int index) {
    screenIndex = index;
    emit(ChangePageState());
  }

  void showBottomSheet({required BuildContext context, required WidgetBuilder builder}) {
    showBottomSheetElevationLayer= true;
    BlocProvider.of<LayoutCubit>(context).builder = builder;

    emit(ShowBottomSheetState());
  }

  void closeBottomSheet({required BuildContext context}) {
    showBottomSheetElevationLayer= false;
    BlocProvider.of<LayoutCubit>(context).builder = (context) => IgnorePointer(child: SizedBox(height: 0,width: 0,));

    emit(CloseBottomSheetState());
  }
}
