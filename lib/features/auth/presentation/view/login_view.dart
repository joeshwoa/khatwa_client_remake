import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:khatwa_client/old_core/contants/api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../old_core/widgets/show_awesomeDialog.dart';
import '../../../../../old_core/widgets/custom_loading_widget.dart';
import '../../../home/views/main_view.dart';
import '../../data/data_source/client_auth_repo.dart';
import '../../../../../old_core/functions/global_function.dart';
import '../../../../../old_core/rescourcs/app_colors.dart';
import '../../../../../old_core/widgets/build_rich_text.dart';
import '../../../../../old_core/widgets/custom_button.dart';
import '../../../../../old_core/widgets/custom_image.dart';
import '../../../../../old_core/widgets/custom_text_button.dart';
import '../../../../../old_core/widgets/custom_text_filed.dart';
import '../../../../../old_core/widgets/snack_bar_widget.dart';
import '../../cubit/login/client_login_cubit.dart';
import '../../forget_password/view/forget_password_view.dart';
import '../../verify_phone/views/otp_view.dart';
import '../../widgets/google_sign_widget.dart';
import 'register_view.dart';

class ClientLoginView extends StatefulWidget {
  const ClientLoginView({super.key});

  @override
  State<ClientLoginView> createState() => _ClientLoginViewState();
}
Future<void> openDriverAppLink() async {

  late Uri url ;
  await read(Uri.parse('${baseUri}driverAppLink')).then((onValue){
    print (onValue);
    url=Uri.parse(jsonDecode(onValue)["driverAppLink"]);
  });

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch ';
  }
}
class _ClientLoginViewState extends State<ClientLoginView> {
  final phone = TextEditingController();
  final password = TextEditingController();
  var PhoneFocus = FocusNode();
  var passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  changeIcon() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    PhoneFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => ClientLoginCubit(ClientAuthRepo()),
        child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ClientLoginCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenSize(context).height * .06),
                        Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CustomAssetsImage(
                                  path: 'assets/logo2.jpeg'),
                            )),
                        SizedBox(height: 10,),
                        const Center(
                            child: Text(" يلا خطوة",style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),)),
                        SizedBox(height: screenSize(context).height * .05),
                        CustomTextFieldWidget(
                          controller: phone,
                          hintText: ' رقم الهاتف',
                          focusNode: PhoneFocus,
                          submit: (p0) => FocusScope.of(context)
                              .requestFocus(passwordFocus),
                          valid: (String? value) {
                            if (value == null) {
                              return 'الرجاء إدخال رقم هاتف صحيح';
                            }

                          },
                        ),
                        SizedBox(height: screenSize(context).height * .03),
                        SizedBox(height: screenSize(context).height * .03),
                        BlocConsumer<ClientLoginCubit,
                            ClientLoginState>(
                            listener: (context, state) {
                          if (state is ClientLoginSuccess) {
                            showSnackBarWidget(
                                context: context,
                                message: 'تم تسجيل الدخوال بنجاح',
                                requestStates: RequestStates.success);
                            //navigateOff(const MainView());
                          } else if (state is ClientSndCodeToEmailState) {
                            showSnackBarWidget(
                                context: context,
                                message:
                                    "لقد تم ارسال كود التحقق الي بريدك الاكتروني",
                                requestStates: RequestStates.success);
                            navigateOff(
                                VerifyPhoneOTPView(
                              phone: phone.text,
                              screen: const MainView(),
                            ));
                          } else if (state is ClientLoginError) {
                            showErrorAwesomeDialog(
                                context, 'تنبيه', state.message);
                          }
                        }, builder: (context, state) {
                          if (state is ClientLoginLoading) {
                            return const CustomLoadingWidget();
                          }
                          return CustomButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<ClientLoginCubit>(context)
                                      .login(phone.text.trim(),
                                          password.text.trim());
                                }
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              color: AppColors.primaryColor,
                              title: 'تسجيل الدخول');
                        }),
                        SizedBox(height: screenSize(context).height * .03),

                        Align(
                            alignment: Alignment.center,
                            child: CustomTextButton(
                                function: () {
                                  navigateTo(const ClientRegisterView());
                                },
                                color: AppColors.primaryColor,
                                title: 'انشاء حساب جديد')),
                        SizedBox(height: screenSize(context).height * .04),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
