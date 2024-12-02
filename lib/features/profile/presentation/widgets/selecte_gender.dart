import 'package:flutter/material.dart';
import '../../controller/client_profile_controller.dart';
import 'package:get/get.dart';

import '../../../../old_core/rescourcs/app_colors.dart';

class SelecteGenderWidget extends StatefulWidget {
  const SelecteGenderWidget({super.key});

  @override
  State<SelecteGenderWidget> createState() => _SelecteGenderWidgetState();
}

class _SelecteGenderWidgetState extends State<SelecteGenderWidget> {
  final controller = Get.find<ClientProfileController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('اختيار النوع'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
            ),
            onPressed: () {
              setState(() {
                controller.genderController.text = 'male';
              });
              Navigator.pop(context);
            },
            child: const Text('ذكر'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
            ),
            onPressed: () {
              setState(() {
                controller.genderController.text = 'female';
              });
              Navigator.pop(context);
            },
            child: const Text('انثي'),
          ),
        ],
      ),
    );
  }
}
