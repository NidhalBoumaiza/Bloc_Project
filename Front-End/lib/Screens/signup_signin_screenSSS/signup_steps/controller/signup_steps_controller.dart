import 'package:get/get.dart';

import '../../../../models/event_model.dart';

class ControllerSignUpSteps extends GetxController {
  RxString email = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
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
  RxBool passwordVisibility = true.obs;
  RxBool confirmpasswordVisibility = true.obs;
  RxBool stepthreeLoading = false.obs;
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
}
