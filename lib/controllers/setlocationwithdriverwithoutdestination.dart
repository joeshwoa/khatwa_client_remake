import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../old_core/contants/api.dart';
import '../dataforcrud/requesttripwithoutdestination.dart';
import 'setlocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../old_core/class/statusrequst.dart';
import '../old_core/functions/global_function.dart';
import '../old_core/functions/handlingdata.dart';
import 'package:http/http.dart' as http;
import '../dataforcrud/nearestdrivers.dart';
import '../features/home/views/driverprofile.dart';

class SetLocationWithDriverWithoutDestinationController extends GetxController {
  late SharedPreferences sharedPreferences;

  RequestTripWithoutDestinationData requestTripWithoutDestinationData =
      RequestTripWithoutDestinationData(Get.find());

  NearestDriversData nearestDriversData = NearestDriversData(Get.find());
  // SetLocationController setLocationController = Get.find();
  //SetLocationGoToController setLocationGoToController = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;
  SetLocationController setLocationController = Get.find();
  double? lat;
  double? long;
  //IO.Socket ? socket;

  Position? position;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;

  // List<Marker> markers = [];
  Set<Marker> newMarker = {};
  String id = "";
  addMarkers(LatLng latLng, Uint8List markerIcon) {
    newMarker.clear();
    newMarker.add(
      Marker(
        markerId: const MarkerId("1"),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          id = driverid!;
          navigateTo(DriverProfile(
            name: drivername!,
            phone: phone!,
          ));
        },
      ),
    );
  }

  Map<String, dynamic>? locations;
  Map<String, dynamic>? locations2;
  List drivers = [];
  String? drivername;
  String? phone;
  String? driverid;
  String? driverimage;
  String? driverimagecar; // Change the type to Uint8List?
  String? drivercarmodel;
  String? cartype;
  Uint8List? driverImageBytes;
  getdrivers(categoryid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await nearestDriversData.postData(
        setLocationController.lat, setLocationController.long, categoryid);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      print(response['drivers']);
      drivers = response['drivers'] ?? [];
      response['drivers'].map((e) {
        newMarker.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(response['drivers'][0]['location']['latitude'],
              response['drivers'][0]['location']['longitude']),
          icon: BitmapDescriptor.fromBytes(driverImageBytes!),
          onTap: () {
            navigateTo(DriverProfile(
              name: drivername!,
              phone: phone!,
            ));
          },
        ));
      });
      // drivers.add(DriversModel.fromJson(response['drivers']));
      if (drivers.isEmpty) {
        //return
          // Get.defaultDialog(
          //   title: 'تنيه', middleText: 'لا يوجد سائق متاحين الان');
      }

      drivername = response['drivers'][0]['driver']['name'];
      phone = response['drivers'][0]['driver']['phone'];
      driverid = response['drivers'][0]['driver']['_id'];
      driverimage = response['drivers'][0]['driver']['image'];
      driverimagecar = response['drivers'][0]['driver']['vehicle']['images'][0];
      cartype = response['drivers'][0]['driver']['vehicle']['model'];
      print("driverimagecar is $driverimagecar");

      // Load the driver image as Uint8List
      driverImageBytes = await loadImage("${baseUri}images/$driverimagecar");
      if (driverImageBytes != null) {
        // Add marker with custom icon
        addMarkers(
          LatLng(response['drivers'][0]['location']['latitude'],
              response['drivers'][0]['location']['longitude']),
          driverImageBytes!,
        );
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(setLocationController.lat!, setLocationController.long!),
      zoom: 14.4746,
    );
    //addMarkers(LatLng(setLocationController.lat!,setLocationController.long!));
    statusRequest = StatusRequest.none;
    update();
  }

  requestTripDriver(id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await requestTripWithoutDestinationData.postData(
      id,
      setLocationController.lat,
      setLocationController.long,
    );
    statusRequest = handlingData(response);
    if (setLocationController.lat == null ||
        setLocationController.long == null) {
      return Get.defaultDialog(
          title: 'تنيه', middleText: 'من فضلك حدد مكان الذهاب ومكان الاقلاع');
    }

    if (StatusRequest.success == statusRequest) {
      if (drivers.isEmpty) {
        return Get.defaultDialog(
            title: 'تنيه', middleText: "لا يمكنك طلب رحله . لا يوجد سائقين");
      }
      return Get.defaultDialog(title: 'تنيه', middleText: "تم الطلب بنجاح");
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  void onInit() async {
    getCurrentLocation();
    completercontroller = Completer<GoogleMapController>();
    sharedPreferences = await SharedPreferences.getInstance();
    if (setLocationController.lat == null ||
        setLocationController.long == null) {
      return Get.defaultDialog(
          title: 'تنيه', middleText: 'من فضلك حدد مكان الذهاب ومكان الاقلاع');
    }
    super.onInit();
  }

  // Function to load the driver image as Uint8List
  // Function to load the driver image as Uint8List and resize it
  Future<Uint8List?> loadImage(String imageUrl) async {
    try {
      http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Resize the image to height 50 and width 50
        List<int> compressedImage = await FlutterImageCompress.compressWithList(
          response.bodyBytes,
          minHeight: 100,
          minWidth: 100,
        );
        return Uint8List.fromList(compressedImage);
      } else {
        print('Failed to load image: ${response.statusCode}');
        print('Failed to load image: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error loading image: $error');
      return null;
    }
  }
}
