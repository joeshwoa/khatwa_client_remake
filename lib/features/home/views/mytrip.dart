import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/mytripcontroller.dart';
import '../../../old_core/class/statusrequst.dart';
import '../../../old_core/functions/global_function.dart';
import 'farescreen.dart';
import 'tracking.dart';
import '../../../old_core/functions/ratingdriver.dart';
import '../../../old_core/rescourcs/app_colors.dart';
import 'trackingwithoutdestionation.dart';

class MyTrip extends StatelessWidget {
  final String id;
  final bool isLast;
  const MyTrip({super.key, required this.id,required this.isLast, });
  @override
  Widget build(BuildContext context) {
    Get.put(MyTripController()..myTrip(id));
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: GetBuilder<MyTripController>(

        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (controller.myTripsModel.status == "requested") {
            return Center(
              child: const Text(
                "",
              ),
            );
          } else if (controller.myTripsModel.status == "accepted") {
             if (controller.myTripsModel.destinationLocation == null) {
                    //go to tracking withoutdestionation
                    return TrackingWithoutDestinatnation(
                      pick1: controller
                          .myTripsModel.pickupLocation!.coordinates!.first,
                      pick2: controller
                          .myTripsModel.pickupLocation!.coordinates!.last,
                      devicetoken: controller.myTripsModel.driver!.deviceToken!,
                      id: controller.myTripsModel.driver!.sId!,
                    );
                  } else {
                    //go to tracking
                    return Tracking(
                      pick1: controller
                          .myTripsModel.pickupLocation!.coordinates!.first,
                      pick2: controller
                          .myTripsModel.pickupLocation!.coordinates!.last,
                      des1: controller
                          .myTripsModel.destinationLocation!.coordinates!.first,
                      des2: controller
                          .myTripsModel.destinationLocation!.coordinates!.first,
                      drivername: controller.myTripsModel.driver!.name!,
                      driverphone: controller.myTripsModel.driver!.phone!,
                      devicetoken: controller.myTripsModel.driver!.deviceToken!,
                      id: controller.myTripsModel.driver!.sId!,
                    );
                  }
                return Text('test');

          } else if (controller.myTripsModel.status == "started") {
            return Center(
              child: Text(
                " تطبيق خطوة يتمني ليك رحلة سعيدة",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            );
          }
          else if (controller.myTripsModel.status == "ended") {

            return FareScreen(
                fare: controller.myTripsModel.fare!.toString(),
                id: controller.myTripsModel.sId!.toString(),isLast: isLast,);
          }
          else {
            return Center(
              child: Text(
                " تم الانتهاء من الرحلة بنجاح",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}




