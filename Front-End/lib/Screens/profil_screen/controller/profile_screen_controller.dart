import 'dart:convert';

import 'package:Bloc/Screens/profil_screen/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../main.dart';

class ControllerProfile extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  RxBool isCheckedSports = false.obs;
  RxBool isCheckedArts = false.obs;
  RxBool isCheckedEducation = false.obs;
  RxBool isCheckedFamily = false.obs;
  RxBool isCheckedBusiness = false.obs;
  RxBool isCheckedAnimals = false.obs;
  RxBool isCheckedEntertainment = false.obs;
  List interests = [];
  RxBool interesrVisibility = false.obs;
  RxDouble distanceValue = 40.0.obs;
  RxBool isLoading = false.obs;
  Profile profile = Profile();
  var futureProfile;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    futureProfile = getProfileInfo();
  }

  Future getProfileInfo() async {
    isLoading.value = true;
    var res = await http.get(
      Uri.parse("$URL/base/profile/"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      isLoading.value = false;
      Map<String, dynamic> jsonData = json.decode(res.body);
      if (jsonData['profile'] != null) {
        profile = Profile.fromJson(jsonData['profile']);
        print(profile.categories);
        return profile;
      } else {
        return false;
      }
    } else {
      print(res.statusCode);
    }
  }

  bool isChecked(category) {
    return profile.categories!.contains(category);
  }

  void addCategory(cat) {
    if (profile.categories!.contains(cat)) {
      profile.categories!.remove(cat);
    } else {
      profile.categories!.add(cat);
    }
  }
}
