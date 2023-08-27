import 'dart:convert';
import 'package:Bloc/component/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../main.dart';

class ControllerSignIn extends GetxController {
  String email = "";
  String password = "";
  RxBool isLoading = false.obs;
  RxBool passwordVisibility = true.obs;

  void login(context) async {
    if (email.isEmpty || password.isEmpty) {
      snackbar(context, 1, "You have to fill your email and password",
          Colors.redAccent);
    } else {
      isLoading.value = true;
      var data = {
        "username": email,
        "password": password,
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": "password",
      };
      var body = jsonEncode(data);

      var res = await http.post(
        Uri.parse("$URL/authentication/token"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      isLoading.value = false;
      print(res.statusCode);
      print(res.body);
      var decoderes = jsonDecode(res.body);
      print(decoderes["access"]);
      if (res.statusCode == 200) {
        saveData("AccessToken", decoderes["access_token"]);
        saveData("RefreshToken", decoderes["refresh_token"]);
        token = decoderes["access_token"];
        Get.toNamed('/signinstepthree');
      } else {
        snackbar(
            context, 2, "The password or Email is incorrect", Colors.redAccent);
      }
    }
  }
}

void saveData(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}
