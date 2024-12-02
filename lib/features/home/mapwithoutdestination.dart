import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../controllers/setlocation.dart';
import '../../../../controllers/setlocationgoto.dart';
import '../../../../controllers/setlocationwithdriver.dart';
import '../../../../old_core/widgets/custom_appBar.dart';
import '../../controllers/setlocationwithdriverwithoutdestination.dart';

class MapScreenWithoutDestination extends StatefulWidget {


  const MapScreenWithoutDestination({super.key});

  @override
  State<MapScreenWithoutDestination> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenWithoutDestination> {
  final String id="";
  @override
  Widget build(BuildContext context) {
    SetLocationWithDriverWithoutDestinationController controllerDriver =
    Get.put(SetLocationWithDriverWithoutDestinationController());
    SetLocationController setLocationController =
    Get.put(SetLocationController());
    // SetLocationGoToController setLocationGoToController =
    // Get.put(SetLocationGoToController());
    return Scaffold(
      appBar: customAppBar(context),
      body: GetBuilder<SetLocationWithDriverWithoutDestinationController>(builder:
          (controller)=>
          Container(
            child: Column(
              children: [
                if(controllerDriver.kGooglePlex!=null)
                  Expanded(child:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        markers: controllerDriver.newMarker.toSet(),
                        onTap: (latlong){
                          // controllerDriver.addMarkers(latlong);
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: controllerDriver.kGooglePlex!,
                        onMapCreated: (GoogleMapController mapcontroller) {
                          controllerDriver.completercontroller!.complete(mapcontroller);
                        },
                      ),
                      (setLocationController.lat != null &&
                          setLocationController.long !=null) ?
                      Positioned(
                        child: Container(),
                      )
                          : Container(
                        child: const Center(child:
                        Text("Please choose your location",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),)),
                      ),
                    ],
                  ) ),
                Container(
                  height: 40,
                  width: 60,
                  color: Colors.orange,
                  child: MaterialButton(
                    onPressed: (){
                      if(controller.id.isNotEmpty) {
                        controller.requestTripDriver(controller.id);
                      }else{
                        Get.defaultDialog(
                            title: 'تنيه',
                            middleText: 'من فضلك قم باختيار سائق');
                      }
                    },
                    child: Text("طلب"),
                  ),),
              ],
            ),
          )),
    );
  }
}
