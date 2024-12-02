import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:khatwa_client/old_core/functions/global_function.dart';
import 'package:khatwa_client/features/home/views/home_view.dart';
import '../../../../controllers/mytripcontroller.dart';
import '../../../../controllers/mytrips.dart';
import '../../../../controllers/setlocation.dart';
import '../../../../controllers/setlocationgoto.dart';
import '../../../../controllers/setlocationwithdriver.dart';
import '../../../../old_core/class/statusrequst.dart';
import '../../../../old_core/widgets/custom_appBar.dart';
import '../farescreen.dart';
import '../tracking.dart';
import '../trackingwithoutdestionation.dart';

class ToSetLocation extends StatefulWidget {
  final String? categoryId;
  const ToSetLocation({super.key, this.categoryId});

  @override
  State<ToSetLocation> createState() => _ToSetLocationState();
}

class _ToSetLocationState extends State<ToSetLocation> {
  late Timer _timer;

  String LastStatus = "";

  @override
  void initState() {
    isAccepted = false;
    isRequesting = false;
    super.initState();
    Geolocator.getCurrentPosition().then((onValue) => {
          setState(() {
            location = Marker(
                markerId: MarkerId('location'),
                position: LatLng(onValue.latitude, onValue.latitude));
          }),
        });
    //Schedule a timer to automatically refresh every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      _refreshData();
    });
  }

  // Method to refresh data or update UI
  void _refreshData() {
    setState(() {
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  var nearestDriverId;

  void _findNearestDriver(
      LatLng startLocation, SetLocationWithDriverController controllerDriver) {
    double shortestDistance = double.infinity;

    // Loop through the drivers and calculate the distance
    controllerDriver.drivers.forEach((driver) {
      print(driver.toString());

      double distance = Geolocator.distanceBetween(
        startLocation.latitude,
        startLocation.longitude,
        driver['location']['latitude'],
        // Assuming driver object has latitude and longitude
        driver['location']['longitude'],
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearestDriverId =
            driver['driver']['_id']; // Store the nearest driver ID
      }
    });

    // After finding the nearest driver, update the UI or handle logic as needed
    setState(() {
      controllerDriver.requestTripDriver(nearestDriverId, context);

      print("Nearest Driver ID: $nearestDriverId, Distance: $shortestDistance");
    });
  }

  bool isChoosingStartLocation = true;
  bool isChoosingDestinationLocation = false;
  bool isChoosingDriver = false;
  bool isRequesting = false;
  bool isAccepted = false;

  // Store the markers
  Marker? location;

  Marker? startMarker;
  Marker? destinationMarker;

  var startFormField = TextEditingController();
  var endFormField = TextEditingController();
  var _startFormField = TextEditingController();
  var _endFormField = TextEditingController();
  SetLocationController setLocationController =
      Get.put(SetLocationController());

  MyTripsController myTripsController = MyTripsController();

  MyTripController myTripController = Get.put(MyTripController());


  @override
  Widget build(BuildContext context) {
    myTripsController.myTrips();


    SetLocationWithDriverController controllerDriver =
        Get.put(SetLocationWithDriverController())
          ..getdrivers(widget.categoryId);


    SetLocationWithDriverController driverController =
        Get.put(SetLocationWithDriverController())
          ..getdrivers(widget.categoryId)
          ..getCurrentLocation();

    print(driverController.toString());


    location = Marker(
        markerId: MarkerId('location'),
        position: LatLng(driverController.position!.latitude,
            driverController.position!.longitude));

    bool ignore = true;

    Get.put(MyTripsController());
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [


          SizedBox(height: 7,),
          GooglePlacesAutoCompleteTextFormField(
              textEditingController: _startFormField,
              googleAPIKey: "AIzaSyAPxtVPKAOPHP1FQV6k7hW9KCSFPzRgRhI",
              debounceTime: 400, // defaults to 600 ms
              countries: ["eg"], // optional, by default the list is empty (no restrictions)
              isLatLngRequired: true, // if you require the coordinates from the place details
              getPlaceDetailWithLatLng: (prediction) {
                // this method will return latlng with place detail
                LatLng latlng=LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));

                startMarker = Marker(
                  markerId: MarkerId('start'),
                  position: latlng,
                  infoWindow:
                  const InfoWindow(title: "Start Location"),
                );
                isChoosingStartLocation = false;
                isChoosingDestinationLocation = true;
                startFormField.text = latlng.toString();
                print("Coordinates: (${prediction.lat},${prediction.lng})");
                _startFormField.text=prediction.description!;
                setState(() {

                });
              }, // this callback is called when isLatLngRequired is true
              itmClick: (prediction) {

              },
            decoration: InputDecoration(
              labelText: 'انطلق من موقعك او اختر موقع',
              hintText: "اختر مكان الانطلاق",
              prefixIcon: Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              labelStyle: TextStyle(color: Colors.grey[700]),
              errorStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              floatingLabelBehavior: FloatingLabelBehavior.auto,



            ),

          ),

          SizedBox(height: 5,),


          GooglePlacesAutoCompleteTextFormField(


              textEditingController: _endFormField,
              googleAPIKey: "AIzaSyAPxtVPKAOPHP1FQV6k7hW9KCSFPzRgRhI",
              debounceTime: 400, // defaults to 600 ms
              countries: ["eg"], // optional, by default the list is empty (no restrictions)
              isLatLngRequired: true, // if you require the coordinates from the place details
              getPlaceDetailWithLatLng: (prediction) {

                LatLng latlng=LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));

                destinationMarker = Marker(
                  markerId: MarkerId('destination'),
                  position: latlng,
                  infoWindow:
                  const InfoWindow(title: "Start Location"),
                );

                isChoosingDestinationLocation = false;
                isChoosingDriver = true;
                endFormField.text = latlng.toString();
                // this method will return latlng with place detail

                _endFormField.text=prediction.description!;


                print("Coordinates: (${prediction.lat},${prediction.lng})");
                setState(() {

                });
              }, // this callback is called when isLatLngRequired is true
              itmClick: (prediction) {

              },

            decoration: InputDecoration(
                labelText: 'الوجهة',
                hintText: "اختر مكان الوصول",
                prefixIcon: Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              labelStyle: TextStyle(color: Colors.grey[700]),
              errorStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              floatingLabelBehavior: FloatingLabelBehavior.auto,

            ),
          ),



          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Main Google Map
                GetBuilder<SetLocationWithDriverController>(
                  builder: (controller) {
                    return GoogleMap(
                      markers: _getMarkers(controllerDriver),
                      // Display markers
                      onTap: (LatLng latLng) {
                        // Step 1: Set Start Location
                        if (isChoosingStartLocation) {
                          setState(() {
                            startMarker = Marker(
                              markerId: MarkerId('start'),
                              position: latLng,
                              infoWindow:
                                  const InfoWindow(title: "Start Location"),
                            );
                            isChoosingStartLocation = false;
                            isChoosingDestinationLocation = true;
                            startFormField.text = latLng.toString();
                          });
                          print(
                              "Start Location: ${latLng.latitude}, ${latLng.longitude}");
                        }
                        // Step 2: Set Destination Location
                        else if (isChoosingDestinationLocation) {
                          setState(() {
                            destinationMarker = Marker(
                              markerId: MarkerId('destination'),
                              position: latLng,
                              infoWindow: const InfoWindow(
                                  title: "Destination Location"),
                            );
                            isChoosingDestinationLocation = false;
                            isChoosingDriver = true;
                            endFormField.text = latLng.toString();
                          });
                          print(
                              "Destination Location: ${latLng.latitude}, ${latLng.longitude}");
                        }
                      },
                      mapType: MapType.normal,
                      initialCameraPosition: driverController.kGooglePlex!,
                      onMapCreated: (GoogleMapController mapController) {
                        if (!driverController
                            .completercontroller!.isCompleted) {
                          driverController.completercontroller!
                              .complete(mapController);
                        }
                      },
                    );
                  },
                ),

                // Floating button to confirm start location
                if (isChoosingStartLocation)
                  Positioned(
                    bottom: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isChoosingStartLocation = false;
                          isChoosingDestinationLocation = true;
                          isChoosingDriver = true;
                          startMarker = Marker(
                            markerId: MarkerId('start'),
                            position: location!.position,
                            infoWindow:
                                const InfoWindow(title: "Start Location"),
                          );
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        child: Text(
                          'confirm location',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                // Floating button to confirm destination location

                // Step 3: Select Driver
                if (isChoosingDriver)
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        if (startMarker != null) {
                          if (startMarker?.position != null) {
                            controllerDriver.setLocationController.lat =
                                startMarker?.position.latitude;
                            controllerDriver.setLocationController.long =
                                startMarker?.position.longitude;
                          }
                        }

                        if (destinationMarker != null) {
                          if (destinationMarker?.position != null) {
                            controllerDriver.setLocationGoToController.lat2 =
                                destinationMarker?.position.latitude;
                            controllerDriver.setLocationGoToController.long2 =
                                destinationMarker?.position.longitude;
                          }
                        }
                        _findNearestDriver(
                            startMarker!.position, controllerDriver);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        child: Text(
                          'يلا خطوة',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                GetBuilder<MyTripsController>(builder: (controller) {
                  if (controller.statusRequest == StatusRequest.loading) {
                    return IgnorePointer(
                        // child: Center(
                        //
                        //   child: const CircularProgressIndicator(
                        //     color: Colors.green,
                        //     backgroundColor: Colors.transparent,
                        //   ),
                        // ),
                        );
                  } else if (controller.trips.isEmpty) {
                    return IgnorePointer(child: Container());
                  } else {
                    print(controller.trips.last.status);
                    if (controller.trips.last.status == "requested") {
                      isRequesting = true;
                    }

                    myTripController.myTrip(controller.trips.last.sId!);

                    if (isRequesting)
                      return GetBuilder<MyTripController>(
                        builder: (controller) {
                          if (controller.statusRequest ==
                              StatusRequest.loading) {
                            ignore = true;
                            return Center(
                              child: const CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            );
                          } else if (controller.myTripsModel.status ==
                              "requested") {
                            ignore = true;
                            return Center(
                              child: const Text(
                                "",
                              ),
                            );
                          } else if (controller.myTripsModel.status ==
                              "accepted") {
                            isAccepted = true;

                            if (controller.myTripsModel.destinationLocation ==
                                null) {
                              ignore = false;

                              //go to tracking withoutdestionation
                              return TrackingWithoutDestinatnation(
                                pick1: controller.myTripsModel.pickupLocation!
                                    .coordinates!.first,
                                pick2: controller.myTripsModel.pickupLocation!
                                    .coordinates!.last,
                                devicetoken: controller
                                    .myTripsModel.driver!.deviceToken!,
                                id: controller.myTripsModel.driver!.sId!,
                              );
                            } else {
                              ignore = false;
                              //go to tracking
                              return Tracking(
                                pick1: controller.myTripsModel.pickupLocation!
                                    .coordinates!.first,
                                pick2: controller.myTripsModel.pickupLocation!
                                    .coordinates!.last,
                                des1: controller.myTripsModel
                                    .destinationLocation!.coordinates!.first,
                                des2: controller.myTripsModel
                                    .destinationLocation!.coordinates!.first,
                                drivername:
                                    controller.myTripsModel.driver!.name!,
                                driverphone:
                                    controller.myTripsModel.driver!.phone!,
                                devicetoken: controller
                                    .myTripsModel.driver!.deviceToken!,
                                id: controller.myTripsModel.driver!.sId!,
                              );
                            }
                            return Text('test');
                          } else if (controller.myTripsModel.status ==
                              "started") {
                            ignore = true;
                            return Center(
                              child: Text(
                                " تطبيق خطوة يتمني ليك رحلة سعيدة",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                            );
                          } else if (controller.myTripsModel.status ==
                              "ended") {
                            ignore = true;
                            if (!isAccepted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                DialogRoute(
                                  context: context,
                                  builder: (context) => HomeView(),
                                ),
                                (route) => false,
                              );
                            }



                            return FareScreen(
                                fare: controller.myTripsModel.fare!.toString(),
                                id: controller.myTripsModel.sId!.toString(),isLast: true,);


                          } else {
                            ignore = true;
                            return Center(
                              child: Text(
                                " تم الانتهاء من الرحلة بنجاح",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.orange),
                              ),
                            );
                          }
                        },
                      );

                    return IgnorePointer();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to get all markers (start, destination, and driver markers)
    Set<Marker> markers = {};
  Set<Marker> _getMarkers(
    controllerDriver,
  ) {

    if (startMarker != null) {
      markers.add(startMarker!); // Add start marker
    }
    if (destinationMarker != null) {
      markers.add(destinationMarker!); // Add destination marker
    }

    controllerDriver.drivers.forEach((driver) {
      markers.add(Marker(
        markerId: MarkerId(driver['driver']['_id']),
        position: LatLng(
          driver['location']['latitude'],
          // Assuming driver object has latitude and longitude
          driver['location']['longitude'],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,

          // You can change the color if needed
        ),
      ));
    });
    markers.add(location!);

    return markers;
  }
  void _onPlaceSelected(LatLng latLng,String name) {
    setState(() {
    // selectedLatLng = latLng;
      markers.add(
        Marker(
          markerId: MarkerId(name),
          position: latLng,
        ),
      );
      // Move the camera to the selected place
      //mab?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
    });
  }
}
