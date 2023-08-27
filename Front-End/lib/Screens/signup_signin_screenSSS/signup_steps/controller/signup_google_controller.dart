import 'dart:convert';

import 'package:Bloc/component/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../../../../main.dart';
import '../../signin_screen/controller/controller_signin.dart';

class ControllerSignUpStepsGoogle extends GetxController {
  RxDouble distance = 5.0.obs;
  List interests = [];
  RxBool? overage;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  RxDouble? Latitude;
  RxDouble? Longitude;
  RxBool isCheckedSports = false.obs;
  RxBool isCheckedArts = false.obs;
  RxBool isCheckedEducation = false.obs;
  RxBool isCheckedFamily = false.obs;
  RxBool isCheckedBusiness = false.obs;
  RxBool isCheckedAnimals = false.obs;
  RxBool isCheckedEntertainment = false.obs;
  RxBool isCheckedOver18 = false.obs;
  RxBool interesrVisibility = false.obs;
  RxBool overageVisibility = false.obs;

  double? latitude;
  double? longitude = 0;
  RxBool isLoadingStepTwo = false.obs;
  //RxList<EventModel> events = [];
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void UpdateDistance(val) {
    distance.value = val;
  }

  void ChnageCheckedValue(val, newVal) {
    val = newVal;
  }

  void finshingAccountCreation(context, access_token, refresh_token) async {
    var body = jsonEncode({
      "distance": distance.value.floor(),
      "prefered_categories": interests,
    });
    var res = await http.post(
      Uri.parse("$URL/auth/finish_signup/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (res.statusCode == 200) {
      saveData("AccessToken", access_token);
      saveData("RefreshToken", refresh_token);
      Get.toNamed("/signinstepthree");
    } else {
      snackbar(context, 2, 'errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrue',
          Colors.redAccent);
    }
  }
}
