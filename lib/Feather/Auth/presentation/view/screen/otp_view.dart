import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:khatwa_client/Core/helper/loading_custom.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';
import 'package:khatwa_client/Core/widget/text_button_custom.dart';
import 'package:khatwa_client/Feather/Auth/presentation/cubit/auth_cubit.dart';
import 'package:khatwa_client/generated/assets.dart';
import 'package:khatwa_client/old_core/rescourcs/app_colors.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {

  late final AuthCubit cubit;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = AuthCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2,tileMode: TileMode.decal),
                child: Image(
                  image: AssetImage(Assets.imagesBackgroundCar),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: ColorData.primaryDarkColor.withOpacity(0.3),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 70),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Assets.imagesAppNameLogo,
                                  height: Unit.screenHeight(18),
                                  fit: BoxFit.cover,
                                ),
                                /*Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      context.read<AppCubit>().updateLung(lung: context.locale == const Locale('en')? 'ar':'en', context: context);
                                    },
                                    child: Text(
                                      'E'.tr(),
                                      style: TextStyle(
                                        color: Color(0xFF95A1AC),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )*/
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                                  child: Text(
                                    'تم أرسل رمز إلى رقم الهاتف الذي أدخلته',
                                    style: StyleData.textStyleWhiteSB20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                children: [
                                  OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: ColorData.whiteColor,
                                    showFieldAsBox: false,
                                    onCodeChanged: (String code) {
                                      otpController.text = code;
                                    },
                                    fieldWidth: Unit.screenWidth(12),
                                    showCursor: true,
                                    readOnly: false,
                                    obscureText: false,
                                    focusedBorderColor: AppColors.primaryColor,
                                    filled: false,
                                    fieldHeight: Unit.screenWidth(12),
                                    cursorColor: AppColors.primaryColor,
                                    enabledBorderColor: ColorData.whiteColor,
                                    borderWidth: 2,
                                    enabled: true,
                                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                                    onSubmit: (String verificationCode){
                                      print(verificationCode);
                                      otpController.text = verificationCode;
                                    },
                                    textStyle: StyleData.textStyleWhiteR16,// end onSubmit
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'تريد ان نرسل الرمز مرة اخري؟',
                                        style: StyleData.textStyleWhiteR14,
                                      ),
                                      Gap(8),
                                      OtpTimerButton(
                                        controller: cubit.resendOTPController,
                                        buttonType: ButtonType.text_button,
                                        loadingIndicatorColor: AppColors.primaryColor,
                                        onPressed: () {
                                          cubit.resendOTP();
                                        },
                                        text: Text(
                                          'ارسل رمز جديد',
                                          style: StyleData.textStyleWhiteR14,
                                        ),
                                        duration: 3 * 60,
                                      )
                                    ],
                                  ),
                                ),
                                ConditionalBuilder(
                                  condition: state is PhoneVerifyLoading,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: LoadingCustom(size: 30,),
                                    );
                                  },
                                  fallback: (BuildContext context) {
                                    return TextButtonCustom(
                                      text: 'ارسل الرمز',
                                      width: Unit.screenWidth(40),
                                      height: Unit.screenWidth(12),
                                      onTap: () {
                                        cubit.verifyWithOTP(otpController.text);
                                      },
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      textStyle: StyleData.textStyleWhiteB18,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          /*Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 24),
                                          child: TextButtonCustom(
                                            text: 'نسيت رقمك السري؟',
                                            width: Unit.screenWidth(40),
                                            height: Unit.screenWidth(12),
                                            onTap: () {
                                              // todo: forget password
                                            },
                                            color: AppColors.white.withOpacity(0),
                                            borderRadius: BorderRadius.circular(0),
                                            border: Border.all(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            textStyle: StyleData.textStyleWhiteM14,
                                          ),
                                        ),
                                        *//*AutoSizeText(
                                          'Visit our Social Pages'.tr(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont(
                                            'Lexend Deca',
                                            color: const Color(0xB2FFFFFF),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    await launchUrl(Uri.parse('https://www.instagram.com/fixer.car.services?igsh=MTh4ZTNiOGRwOW9oeA=='));
                                                  },
                                                  child: Card(
                                                    clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(50),
                                                    ),
                                                    child: Image.asset(
                                                      Assets.imagesInstagram,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    await launchUrl(Uri.parse('https://www.facebook.com/CarsFixer?mibextid=ZbWKwL'));
                                                  },
                                                  child: Card(
                                                    clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                    color: const Color(0xFF090F13),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(50),
                                                    ),
                                                    child: Image.asset(
                                                      Assets.imagesFacebook,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    await launchUrl(Uri.parse('https://wa.me/201208799962'));
                                                  },
                                                  child: Card(
                                                    clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                    color: const Color(0xFF090F13),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(50),
                                                    ),
                                                    child: Image.asset(
                                                      Assets.imagesWhatsapp,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  await launchUrl(Uri(scheme: 'tel', path: '01208799962',));
                                                },
                                                child: Card(
                                                  clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                                  color: const Color(0xFF090F13),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                  ),
                                                  child: Image.asset(
                                                    Assets.imagesTelephone,
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),*//*
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              /*Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 54),
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      width: Unit.screenWidth(90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(Unit.screenHeight(3)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: AssetImage(Assets.imagesBanner),
                              width: Unit.screenWidth(90),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(Unit.screenHeight(3)),
                          Text(
                            "يلا خطوة",
                            style: StyleData.textStyleWhiteB36,
                          ),
                          Gap(Unit.screenHeight(1)),
                          Text(
                            "مع خطوة اوصل الي اي مكان في دقائق بضغطة زر",
                            style: StyleData.textStyleWhiteSB20,
                            textAlign: TextAlign.start,
                          ),
                          Gap(Unit.screenHeight(6)),
                          TextFieldCustom(
                            controller: phoneController,
                            hintText: 'رقم الهاتف',
                            validator: (value) {
                              if (value == null || value.length != 11) {
                                return 'إدخل رقم هاتف صحيح';
                              }
                              return null;
                            },
                          )
                          *//*CustomTextFieldWidget(
                            controller: phoneController,
                            hintText: 'رقم الهاتف',
                            submit: (p0) => FocusScope.of(context)
                                .requestFocus(passwordFocus),
                            validator: (String? value) {
                              if (value == null) {
                                return 'الرجاء إدخال رقم هاتف صحيح';
                              }

                            },
                          ),
                          Gap(Unit.screenHeight(6)),
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
                          SizedBox(height: screenSize(context).height * .04),*//*

                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          );
        },
      ),
    );
  }
}
