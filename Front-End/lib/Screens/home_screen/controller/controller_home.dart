import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/Event.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../main.dart';

class ControllerHome extends GetxController {
  RxList<Event> events = <Event>[].obs;
  RxList<Event> eventsAll = <Event>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLiking = false.obs;
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   //getHomeEvents("partial");
  // }

  // Function to fetch and parse JSON data
  Future getHomeEvents(type) async {
    isLoading.value = true;
    print(isLoading.value);
    var res = await http.get(
      Uri.parse("$URL/base/home/?type=$type"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      isLoading.value = false;
      // Simulate fetching data from the API
      Map<String, dynamic> jsonData = json.decode(res.body);
      // Parse the JSON data and populate the events list
      if (jsonData['events'] != null) {
        if (type == "all") {
          eventsAll.value = List<Event>.from(
            jsonData['events'].map((x) => Event.fromJson(x)),
          );
        } else {
          events.value = List<Event>.from(
            jsonData['events'].map((x) => Event.fromJson(x)),
          );
        }
      }
      if (type == "all") {
        return eventsAll;
      } else {
        return events;
      }
    } else {
      isLoading.value = false;
      print(isLoading.value);
      return 0;
    }
  }

  void like(id, preference, currentValue, index) async {
    isLiking.value = true;
    if (preference == "like" && events[index].like?.value == 0) {
      events[index].like?.value = 1;
      events[index].score?.value += 1;
    } else if (preference == "like" && events[index].like?.value == 1) {
      events[index].like?.value = 0;
      events[index].score?.value -= 1;
    } else if (preference == "like" && events[index].like?.value == -1) {
      events[index].like?.value = 1;
      events[index].score?.value += 2;
    } else if (preference == "dislike" && events[index].like?.value == 0) {
      events[index].like?.value = -1;
      events[index].score?.value -= 1;
    } else if (preference == "dislike" && events[index].like?.value == 1) {
      events[index].like?.value = -1;
      events[index].score?.value -= 2;
    } else if (preference == "dislike" && events[index].like?.value == -1) {
      events[index].like?.value = 0;
      events[index].score?.value += 1;
    }
    var body = jsonEncode({"event_id": id, "preference": preference});
    var res = await http.patch(
      Uri.parse("$URL/base/rateevent/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    if (res.statusCode == 200) {
      isLiking.value = false;
    }
  }
}
