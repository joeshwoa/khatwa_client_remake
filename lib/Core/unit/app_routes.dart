import 'package:go_router/go_router.dart';
import 'package:khatwa_client/Feather/Auth/presentation/view/screen/login_view.dart';
import 'package:khatwa_client/Feather/Auth/presentation/view/screen/otp_view.dart';
import 'package:khatwa_client/Feather/Auth/presentation/view/screen/sign_up_view.dart';
import 'package:khatwa_client/Feather/Layout/presentation/view/screen/layout_custom.dart';
import 'package:khatwa_client/Feather/Layout/presentation/view/screen/splash_view.dart';


abstract class AppRouter {

  //User
  static const kAppSplashView='/';
  static const kLoginView='/login';
  static const kSignUpView='/SignUpView';
  static const kOTPView='/OTPView';
  static const kLayoutView='/layout';

  static final GoRouter router = GoRouter(
    routes: [
      // User
      GoRoute(
          path: kAppSplashView,
          builder: (context, state){
            return SplashView();
          }),
      GoRoute(
          path: kLoginView,
          builder: (context, state){
            return LoginView();
          }),
      GoRoute(
          path: kSignUpView,
          builder: (context, state){
            return SignUpView();
          }),
      GoRoute(
          path: kOTPView,
          builder: (context, state){
            return OTPView();
          }),
      GoRoute(
          path: kLayoutView,
          builder: (context, state){
            return LayoutCustom();
          }),
    ],
  );
}
