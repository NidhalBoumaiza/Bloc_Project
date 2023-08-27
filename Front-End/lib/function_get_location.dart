import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Screens/signup_signin_screenSSS/signup_steps/signup_step_one.dart';
import 'constants.dart';
import 'main.dart';

void getCurrentLocation(context) async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (serviceEnable) {
    LocationPermission checkpermission = await Geolocator.checkPermission();

    if (checkpermission == LocationPermission.denied) {
      LocationPermission requestpermission =
          await Geolocator.requestPermission();
      //------------------------------
      if (requestpermission == LocationPermission.whileInUse) {
        Get.toNamed('/motherscreen');
      }
      //------------------------------
    } else {
      var cordonne = await Geolocator.getCurrentPosition();
      controllerSignUpSteps.latitude = cordonne.latitude;
      controllerSignUpSteps.longitude = cordonne.longitude;
      var data = {
        "lat": controllerSignUpSteps.latitude,
        "long": controllerSignUpSteps.longitude
      };
      var body = jsonEncode(data);
      var res = await http.patch(
        Uri.parse("$URL/base/update_location/"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      Get.toNamed('/motherscreen');
    }
    controllerSignUpSteps.stepthreeLoading.value = false;
  } else {
    bool locationOpened = await Geolocator.openLocationSettings();
    controllerSignUpSteps.stepthreeLoading.value = false;
    print("no");
  }
}

void liveLocation() {
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 100,
  );

  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
    controllerSignUpSteps.latitude = position.latitude;
    controllerSignUpSteps.longitude = position.longitude;
  });
}

Future<String?> GetAddressFromLatLong(lat, long) async {
  List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
  return placemark[0].street;
}
