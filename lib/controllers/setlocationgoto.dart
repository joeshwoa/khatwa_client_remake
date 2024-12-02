import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../old_core/class/statusrequst.dart';

class SetLocationGoToController extends GetxController{

  StatusRequest statusRequest = StatusRequest.loading;
  Position? position;
  Completer<GoogleMapController>? completercontroller ;
  CameraPosition? kGooglePlex ;

  List<Marker> markers = [];
  double ? lat2;
  double ? long2;

  addMarkers(LatLng latLng){
    markers.clear();
    markers.add(Marker(markerId: MarkerId("1"),position:latLng));
    lat2=latLng.latitude;
    long2=latLng.longitude;
    update();
   
  }
  

  getCurrentLocation()async{
    position = await Geolocator.getCurrentPosition();
    kGooglePlex =  CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    addMarkers(LatLng(position!.latitude, position!.longitude));
    statusRequest=StatusRequest.none;

    update();

  }

  @override
  void onInit() {
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();

    super.onInit();
  }
}