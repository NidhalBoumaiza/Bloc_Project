import 'dart:convert';

import 'package:Bloc/component/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class ControllerCreateScreen extends GetxController {
  RxString eventName = "".obs;
  RxString eventLink = "".obs;
  RxString localisation = "".obs;
  RxString startDate = "".obs;
  RxString endDate = "".obs;
  RxString startTime = "".obs;
  RxString endTime = "".obs;
  RxString eventType = "Type of Events".obs;
  RxString photo = "".obs;
  RxDouble distance = 2.0.obs;
  double? eventLatitude;
  double? eventLongitude;
  String base64 = "";
  RxBool isLoading = false.obs;
  bool ControlVerification(context) {
    if (eventName.isEmpty ||
        localisation.isEmpty ||
        startDate.isEmpty ||
        endDate.isEmpty ||
        startTime.isEmpty ||
        endTime.isEmpty ||
        photo.isEmpty ||
        eventType == "Type of Events" ||
        eventLink.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void createEvent(context) async {
    isLoading.value = true;
    String startDateTime = "${startDate.value} ${startTime.value}";
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    var start_date_time = dateFormat.parse(startDateTime);

    ///--------------
    String endDateTime = "${endDate.value} ${endTime.value}";
    var end_date_time = dateFormat.parse(endDateTime);
    var data = {
      "event_name": eventName.value,
      "lat": eventLatitude,
      "long": eventLongitude,
      "location_name": localisation.value,
      "event_category": eventType.value,
      "picture": base64,
      "start_date": start_date_time.toIso8601String(),
      "end_date": end_date_time.toIso8601String(),
      "link": eventLink.value,
      "distance": distance.value,
    };

    var body = json.encode(data);

    var res = await http.post(
      Uri.parse('$URL/base/create_event/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    if (res.statusCode == 200) {
      isLoading.value = false;
      eventName.value = "";
      eventLink.value = "";
      localisation.value = "";
      startDate.value = "";
      endDate.value = "";
      startTime.value = "";
      endTime.value = "";
      eventType.value = "Type of Events";
      photo.value = "";
      distance.value = 2.0;
      eventLatitude = 0;
      eventLongitude = 0;
      base64 = "";
      snackbar(
          context, 1, "The event has been created successfully", Colors.green);
    } else {
      isLoading.value = false;
      snackbar(context, 1, "errorrorororororor", Colors.redAccent);
    }
  }
}

// @override
// void onClose() {
//   // TODO: implement dispose
//   super.dispose();
//   print('byeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
//   eventName = "".obs;
//   localisation = "".obs;
//   startDate = "".obs;
//   endDate = "".obs;
//   startTime = "".obs;
//   endTime = "".obs;
//   eventType = "".obs;
//   photo = "".obs;
//   distance = 2.0.obs;
//   selectedOption = "Type of Events".obs;
// }
