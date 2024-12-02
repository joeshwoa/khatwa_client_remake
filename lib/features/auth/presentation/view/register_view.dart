import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../old_core/widgets/custom_loading_widget.dart';
import '../../../../../old_core/widgets/show_awesomeDialog.dart';
import '../../../home/views/main_view.dart';
import '../../cubit/register/client_register_cubit.dart';
import '../../../../../old_core/functions/global_function.dart';
import '../../../../../old_core/rescourcs/app_colors.dart';
import '../../../../../old_core/widgets/custom_button.dart';
import '../../../../../old_core/widgets/custom_image.dart';
import '../../../../../old_core/widgets/custom_text_filed.dart';
import '../../../../../old_core/widgets/snack_bar_widget.dart';

import '../../../../../old_core/widgets/build_rich_text.dart';

import '../../data/data_source/client_auth_repo.dart';
import '../../verify_phone/views/otp_view.dart';
import '../../widgets/google_sign_widget.dart';

class ClientRegisterView extends StatefulWidget {
  const ClientRegisterView({super.key});

  @override
  State<ClientRegisterView> createState() => _ClientRegisterViewState();
}

class _ClientRegisterViewState extends State<ClientRegisterView> {
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  var phoneFocus = FocusNode();
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  var nameFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  changeIcon() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    password.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    nameFocus.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => ClientRegisterCubit(ClientAuthRepo()),
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Center(
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
                            child: CustomAssetsImage(path: 'assets/logo2.jpeg'),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      const Center(
                          child: Text(
                        " يلا خطوة",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(height: screenSize(context).height * .05),
                      CustomTextFieldWidget(
                        controller: name,
                        focusNode: nameFocus,
                        submit: (p0) =>
                            FocusScope.of(context).requestFocus(emailFocus),
                        hintText: 'الاسم',
                        valid: (String? value) {
                          if (value == null) {
                            return 'قيمة فارغة غير صالحة';
                          }
                        },
                      ),
                      SizedBox(height: screenSize(context).height * .03),
                      CustomTextFieldWidget(
                        controller: phone,
                        focusNode: phoneFocus,
                        submit: (p0) =>
                            FocusScope.of(context).requestFocus(phoneFocus),
                        hintText: 'رقم الهاتف',
                        valid: (String? value) {
                          if (value == null) {
                            return 'قيمة فارغة غير صالحة';
                          }
                        },
                      ),
                      SizedBox(height: screenSize(context).height * .05),
                      BlocConsumer<ClientRegisterCubit, ClientRegisterState>(
                          listener: (context, state) {
                        if (state is ClientRegisterSuccess) {
                          showSnackBarWidget(
                              context: context,
                              message: 'تم انشاء الحساب بنجاح',
                              requestStates: RequestStates.success);
                          navigateOff(VerifyPhoneOTPView(
                            phone: phone.text,
                            screen: const MainView(),
                          ));
                        } else if (state is ClientRegisterError) {
                          showErrorAwesomeDialog(
                              context, 'تنبيه', state.message);
                        }
                      }, builder: (context, state) {
                        if (state is ClientRegisterLoading) {
                          return const CustomLoadingWidget();
                        }
                        return CustomButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<ClientRegisterCubit>(context)
                                    .register(
                                        name.text.trim(), phone.text.trim());
                              }
                              // navigateOff(VerifyPhoneOTPView(
                              //   phone: phone.text,
                              //   screen: const MainView(),
                              // ));

                              //navigateTo(screen)
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            color: AppColors.primaryColor,
                            title: 'انشاء حساب');
                      }),
                      SizedBox(height: screenSize(context).height * .03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
