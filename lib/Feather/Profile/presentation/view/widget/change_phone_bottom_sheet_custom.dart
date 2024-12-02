import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Core/helper/loading_custom.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Core/unit/style_data.dart';
import 'package:khatwa_client/Core/unit/unit.dart';
import 'package:khatwa_client/Core/widget/text_button_custom.dart';
import 'package:khatwa_client/Core/widget/text_field_custom.dart';
import 'package:khatwa_client/Feather/Layout/presentation/cubit/layout_cubit.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_cubit.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_states.dart';
import 'package:khatwa_client/old_core/rescourcs/app_colors.dart';

class ChangePhoneBottomSheetCustom extends StatefulWidget {
  const ChangePhoneBottomSheetCustom({super.key});

  @override
  State<ChangePhoneBottomSheetCustom> createState() => _ChangePhoneBottomSheetCustomState();
}

class _ChangePhoneBottomSheetCustomState extends State<ChangePhoneBottomSheetCustom> {

  late final ProfileCubit cubit;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  final FocusNode phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    cubit = ProfileCubit.get(context);
    phoneController.text = cubit.clientProfileModel?.phone??'';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Unit.screenHeight(70),
      child: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) => BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 16,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: IconButton(
                              onPressed: () {
                                LayoutCubit.get(context).closeBottomSheet(context: context);
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                color: ColorData.dangerColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'تغير رقم الهاتف',
                          style: StyleData.textStyleBlackB20,
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFieldCustom(
                            controller: phoneController,
                            hintText: 'رقم الهاتف',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'إدخل ؤقم الهاتف صحيح';
                              }
                              return null;
                            },
                            style: StyleData.textStyleBlackR16,
                            hintStyle: StyleData.textStyleBlackR16,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32,),
                    ConditionalBuilder(
                      condition: state is UpdateProfileNameLoading,
                      builder: (BuildContext context) {
                        return const Center(
                          child: LoadingCustom(size: 30,),
                        );
                      },
                      fallback: (BuildContext context) {
                        return TextButtonCustom(
                          text: 'حفظ التغيرات',
                          width: Unit.screenWidth(40),
                          height: Unit.screenWidth(12),
                          onTap: () {
                            cubit.updateProfile(phone: phoneController.text);
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
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
