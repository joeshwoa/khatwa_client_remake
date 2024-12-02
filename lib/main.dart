import 'dart:developer';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:khatwa_client/Core/api/constant_api.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Feather/Activity/presentation/cubit/activity_cubit.dart';
import 'package:khatwa_client/Feather/Auth/presentation/cubit/auth_cubit.dart';
import 'package:khatwa_client/Feather/Home/presentation/cubit/home_cubit.dart';
import 'package:khatwa_client/Feather/Layout/presentation/cubit/layout_cubit.dart';
import 'package:khatwa_client/Core/services/custom_bloc_observer.dart';
import 'package:khatwa_client/Core/services/shared_pref_services.dart';
import 'package:khatwa_client/Core/translations/codegen_loader.g.dart';
import 'package:khatwa_client/Core/unit/app_routes.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_cubit.dart';
import 'package:khatwa_client/Feather/Setting/presentation/cubit/setting_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'old_core/uitils/service_locator.dart';
import 'old_core/functions/location.dart';
import 'old_core/helper/notifictions_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  requestPermissionLocation();
  String tok = await FirebaseMessagingService.getDeviceToken();
  String tok2 = await FirebaseMessagingService.getAccessToken();
  log("device token ${tok}");
  log("access token ${tok2}");
  setupServiceLocator();

  await dotenv.load(fileName: ".env");

  Bloc.observer = CustomBlocObserver();
  await SharedPreferencesServices.init();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: Locale(ConstantData.kDefaultLung),
        startLocale: Locale(SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung),
        assetLoader: const CodegenLoader(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider (create: (BuildContext context) => AuthCubit(),),
            BlocProvider (create: (BuildContext context) => LayoutCubit(),),
            BlocProvider (create: (BuildContext context) => HomeCubit(),),
            BlocProvider (create: (BuildContext context) => ActivityCubit(),),
            BlocProvider (create: (BuildContext context) => SettingCubit(),),
            BlocProvider (create: (BuildContext context) => ProfileCubit(),),
          ],
          child: MyApp(),)));
  });


}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Unit.init(context: context);
    StyleData.init(context: context, fontFamily: 'Rubik');
    ConstantApi.init(nameDomain: 'api-khtwa.com', endPoint: '/');
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorData.primaryColor, brightness: Brightness.light),
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: ColorData.primary25Color,
      ),
      dark: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorData.primaryDarkColor, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorData.primary25DarkColor,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp.router(
        theme: theme,
        darkTheme: darkTheme,
        title: 'خطوة',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CacheStorageServices.init();
  requestPermissionLocation();
  HttpOverrides.global = MyHttpOverrides();
  String tok = await FirebaseMessagingService.getDeviceToken();
  String tok2 = await FirebaseMessagingService.getAccessToken();
  log("device token ${tok}");
  log("access token ${tok2}");
  setupOrientation();
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  runApp(const SeliveryClient());
}

void setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}*/
