

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:khatwa_client/Feather/Home/presentation/cubit/home_cubit.dart';
import 'package:khatwa_client/Feather/Home/presentation/cubit/home_states.dart';
import 'package:khatwa_client/Feather/Home/presentation/view/widget/choose_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isChoosingStartLocation = true;
bool isChoosingDestinationLocation = false;
bool isChoosingDriver = false;
bool isRequesting = false;
bool isAccepted = false;

Marker? location;

// Store the markers

Marker? startMarker;
Marker? destinationMarker;

var startFormField = TextEditingController();
var endFormField = TextEditingController();
var _startFormField = TextEditingController();
var _endFormField = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    Geolocator.getCurrentPosition().then((onValue) => {
          setState(() {
            location = Marker(
                markerId: MarkerId('location'),
                position: LatLng(onValue.latitude, onValue.longitude));
          }),
        });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        markers.clear();

        return Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Main Google Map
                        GoogleMap(
                          myLocationButtonEnabled: true,

                          markers: _getMarkers(),
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

                            else if (startMarker!=null&&destinationMarker!=null)
                              {


                               setState(() {

                                 markers.clear();

                                 startMarker=null;
                                destinationMarker=null;
                                isChoosingStartLocation=true;
                               });




                              }
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(26.8206, 30.8025), zoom: 5.5),
                          myLocationEnabled: true,

                          onMapCreated: (GoogleMapController mapController) {
                            // if (!driverController
                            //     .completercontroller!.isCompleted) {
                            //   driverController.completercontroller!
                            //       .complete(mapController);
                            // }
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
                        if (isChoosingDriver && startMarker != null)
                          Positioned(
                            bottom: 20,
                            child: ElevatedButton(
                              onPressed: () {

                                showBottomSheet(context: context, builder: (context) {


                                  //
                                  // builder: (context) =>
                                  return   ChooseCategoriesScreen();


                                  //  );
                                },
                                  showDragHandle: true,

                                );
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


                          Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GooglePlacesAutoCompleteTextFormField(
                                textEditingController: _startFormField,
                                googleAPIKey: dotenv.env['GOOGLE_API_KEY']??'',
                                debounceTime: 400, // defaults to 600 ms
                                countries: [
                                  "eg"
                                ], // optional, by default the list is empty (no restrictions)
                                isLatLngRequired:
                                true, // if you require the coordinates from the place details
                                getPlaceDetailWithLatLng: (prediction) {
                                  // this method will return latlng with place detail
                                  LatLng latlng = LatLng(
                                      double.parse(prediction.lat!),
                                      double.parse(prediction.lng!));

                                  startMarker = Marker(
                                    markerId: MarkerId('start'),
                                    position: latlng,
                                    infoWindow:
                                    const InfoWindow(title: "Start Location"),
                                  );
                                  isChoosingStartLocation = false;
                                  isChoosingDestinationLocation = true;
                                  startFormField.text = latlng.toString();
                                  print(
                                      "Coordinates: (${prediction.lat},${prediction.lng})");
                                  _startFormField.text = prediction.description!;
                                  setState(() {});
                                }, // this callback is called when isLatLngRequired is true
                                itmClick: (prediction) {},
                                decoration: InputDecoration(
                                  labelText: 'انطلق من موقعك او اختر موقع',
                                  hintText: "اختر مكان الانطلاق",
                                  prefixIcon: Icon(Icons.location_on_outlined,
                                      color: Theme.of(context).primaryColor),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent, width: 2.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 20.0),
                                  labelStyle: TextStyle(color: Colors.grey[700]),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GooglePlacesAutoCompleteTextFormField(
                                textEditingController: _endFormField,
                                googleAPIKey: dotenv.env['GOOGLE_API_KEY']??'',
                                debounceTime: 400, // defaults to 600 ms
                                countries: [
                                  "eg"
                                ], // optional, by default the list is empty (no restrictions)
                                isLatLngRequired:
                                true, // if you require the coordinates from the place details
                                getPlaceDetailWithLatLng: (prediction) {
                                  LatLng latlng = LatLng(
                                      double.parse(prediction.lat!),
                                      double.parse(prediction.lng!));

                                  destinationMarker = Marker(
                                    markerId: MarkerId('destination'),
                                    position: latlng,
                                    infoWindow: const InfoWindow(
                                        title: "Destination Location"),
                                  );

                                  isChoosingDestinationLocation = false;
                                  isChoosingDriver = true;
                                  endFormField.text = latlng.toString();
                                  // this method will return latlng with place detail

                                  _endFormField.text = prediction.description!;

                                  print(
                                      "Coordinates: (${prediction.lat},${prediction.lng})");
                                  setState(() {});
                                }, // this callback is called when isLatLngRequired is true
                                itmClick: (prediction) {},

                                decoration: InputDecoration(
                                  labelText: 'الوجهة',
                                  hintText: "اختر مكان الوصول",
                                  prefixIcon: Icon(Icons.location_on_outlined,
                                      color: Theme.of(context).primaryColor),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent, width: 2.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 20.0),
                                  labelStyle: TextStyle(color: Colors.grey[700]),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                              ),
                            ),
                          ],
                        ),










                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },

    );
  }
}

Set<Marker> markers = {};
Set<Marker> _getMarkers() {
  if (startMarker != null) {
    markers.add(startMarker!); // Add start marker
  }
  if (destinationMarker != null) {
    markers.add(destinationMarker!); // Add destination marker
  }

  return markers;
}

