import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../controllers/setlocation.dart';
import '../../../../old_core/rescourcs/app_colors.dart';

class SetLaunchLocation extends StatelessWidget {
  const SetLaunchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    // SetLocationController addAddressController =
    Get.put(SetLocationController(), permanent: false);
    return GetBuilder<SetLocationController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "حدد مكان الاقلاع",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: GetBuilder<SetLocationController>(
          builder: (addAddressController) => Container(
            child: Column(
              children: [
                if (addAddressController.kGooglePlex != null)
                  Expanded(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        markers: addAddressController.markers.toSet(),
                        onTap: (latlong) {
                          addAddressController.addMarkers(latlong);
                          print(latlong);
                        },
                        mapType: MapType.normal,
                        initialCameraPosition:
                            addAddressController.kGooglePlex!,
                        onMapCreated: (GoogleMapController mapcontroller) {
                          // controller.completercontroller!.complete(mapcontroller);
                          if (!addAddressController
                              .completercontroller!.isCompleted) {
                            addAddressController.completercontroller!
                                .complete(mapcontroller);
                          }
                        },
                      ),
                    ],
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
