import 'package:get/get.dart';

import 'event_model.dart';

class AccountModel {
  RxString? email = "".obs;
  RxString? firstName;
  RxString? lastName;
  RxDouble distance = 5.0.obs;
  RxList<String> interests = [""].obs;
  RxBool? overage;
  RxString? password;
  RxString? confirmPassword;
  RxDouble? Latitude;
  RxDouble? Longitude;
  //RxList<EventModel> events = [];
}
