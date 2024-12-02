import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../old_core/rescourcs/app_colors.dart';
import '../widgets/update_profile.dart';
import '../../../../../old_core/widgets/custom_loading_widget.dart';
import '../../../../old_core/widgets/error_componant.dart';
import '../../controller/client_profile_controller.dart';
import '../../../../../old_core/functions/global_function.dart';
import '../../../../../old_core/widgets/custom_sized_box.dart';
import '../../../../../../old_core/widgets/custom_appBar.dart';
import '../../data/model/client_profile_model.dart';
import '../widgets/client_user_info.dart';
import '../widgets/top_title.dart';
import 'client_edit_profile.dart';

class ClientProfileView extends StatefulWidget {
  const ClientProfileView({super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  final controller = Get.find<ClientProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: GetBuilder<ClientProfileController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const CustomLoadingWidget();
          } else if (controller.errorMessage.isNotEmpty) {
            return ErrorComponant(
                function: () => controller.getClientProfile(),
                message: controller.errorMessage);
          }
          return clientProfileBody(controller.clientProfileModel);
        },
      ),
    );
  }

  Center clientProfileBody(ClientProfileModel? clientModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TopTitleWidget(
            //   title1: 'عم',
            //   title2: 'يل',
            //   image: clientModel?.image,
            //   name: clientModel?.name,
            // ),
            Text(
              "${clientModel!.name}",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            ClientUserInfo(clientModel: clientModel),
            const CustomSizedBox(value: .03),
            UpdateProfile(
              function: () => navigateTo(const ClientEditProfileView()),
            ),
          ],
        ),
      ),
    );
  }
}
