import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/button_next.dart';
import '../../../component/snack_bar.dart';
import '../../../component/text_field.dart';
import '../../../component/text_widget.dart';
import '../../../constants.dart';
import 'controller/signup_steps_controller.dart';

class SignUpStepOne extends StatelessWidget {
  const SignUpStepOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerSignUpSteps controllerSignUpSteps =
        Get.find<ControllerSignUpSteps>();
    TextEditingController controllerEmail =
        TextEditingController(text: controllerSignUpSteps.email.value);
    TextEditingController controllerfirstname =
        TextEditingController(text: controllerSignUpSteps.firstName.value);
    TextEditingController controllerlastname =
        TextEditingController(text: controllerSignUpSteps.lastName.value);

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: appBar,
          backgroundColor: AppColor.mainColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  TextWidget("Enter your details", const Color(0xffF6F6F6),
                      22.0, FontWeight.w400, 0.5),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: TextFieldWidget((String ch) {
                      controllerSignUpSteps.email.value = ch;
                    }, TextInputType.emailAddress, "Email",
                        controller: controllerEmail),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget((String ch) {
                          controllerSignUpSteps.firstName.value = ch;
                        }, TextInputType.text, "First",
                            controller: controllerfirstname),
                      ),
                      const SizedBox(width: 35),
                      Expanded(
                        child: TextFieldWidget((String ch) {
                          controllerSignUpSteps.lastName.value = ch;
                        }, TextInputType.text, "Last",
                            controller: controllerlastname),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextWidget("Distance from your location",
                      const Color(0xffF6F6F6), 17.0, FontWeight.w300, 0.2),
                  const SizedBox(height: 5),
                  TextWidget("select the distance of events from your location",
                      Colors.grey, 11.0, FontWeight.w300, 0.0),
                  const SizedBox(height: 15),
                  SliderTheme(
                    data: const SliderThemeData(
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 0.0, // Set the size of the overlay
                      ),
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      // Set the value indicator shape
                      showValueIndicator: ShowValueIndicator.always,
                      // Show the value indicator
                      trackHeight: 1.5,
                      // rangeThumbShape: RangeSliderThumbShape(),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 5.0,
                        pressedElevation: 0,
                      ),
                      valueIndicatorTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    child: Obx(
                      () => Slider(
                        label:
                            "${controllerSignUpSteps.distance.value.floor().toString()} Km",
                        min: 5,
                        max: 200,
                        value: controllerSignUpSteps.distance.value,
                        onChanged: (val) {
                          controllerSignUpSteps.UpdateDistance(val);
                        },
                        thumbColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  //TYPE OF EVENTS********************************************
                  //**********************************************************
                  Column(
                    children: [
                      TextWidget(
                          "select what types of events you are interested in",
                          Colors.grey,
                          11.0,
                          FontWeight.w300,
                          0.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedSports.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps
                                        .isCheckedSports.value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedSports.value) {
                                      controllerSignUpSteps.interests
                                          .add("sports");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("sports");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps.isCheckedSports.value =
                                      !controllerSignUpSteps
                                          .isCheckedSports.value;
                                  if (controllerSignUpSteps
                                      .isCheckedSports.value) {
                                    controllerSignUpSteps.interests
                                        .add("sports");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("sports");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Sports",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value:
                                      controllerSignUpSteps.isCheckedArts.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps.isCheckedArts.value =
                                        newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedArts.value) {
                                      controllerSignUpSteps.interests
                                          .add("art");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("arts");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps.isCheckedArts.value =
                                      !controllerSignUpSteps
                                          .isCheckedArts.value;
                                  if (controllerSignUpSteps
                                      .isCheckedArts.value) {
                                    controllerSignUpSteps.interests.add("arts");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("arts");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget("Arts", AppColor.forthColor,
                                      11.0, FontWeight.w400, 0.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedEducation.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps
                                        .isCheckedEducation.value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedEducation.value) {
                                      controllerSignUpSteps.interests
                                          .add("education");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("education");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps
                                          .isCheckedEducation.value =
                                      !controllerSignUpSteps
                                          .isCheckedEducation.value;
                                  if (controllerSignUpSteps
                                      .isCheckedEducation.value) {
                                    controllerSignUpSteps.interests
                                        .add("education");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("education");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Education",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedFamily.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps
                                        .isCheckedFamily.value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedFamily.value) {
                                      controllerSignUpSteps.interests
                                          .add("family");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("family");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps.isCheckedFamily.value =
                                      !controllerSignUpSteps
                                          .isCheckedFamily.value;
                                  if (controllerSignUpSteps
                                      .isCheckedFamily.value) {
                                    controllerSignUpSteps.interests
                                        .add("family");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("family");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Family",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedBusiness.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps
                                        .isCheckedBusiness.value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedBusiness.value) {
                                      controllerSignUpSteps.interests
                                          .add("business");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("business");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps
                                          .isCheckedBusiness.value =
                                      !controllerSignUpSteps
                                          .isCheckedBusiness.value;
                                  if (controllerSignUpSteps
                                      .isCheckedBusiness.value) {
                                    controllerSignUpSteps.interests
                                        .add("business");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("business");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Business",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedAnimals.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps
                                        .isCheckedAnimals.value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedAnimals.value) {
                                      controllerSignUpSteps.interests
                                          .add("animals");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("animals");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps.isCheckedAnimals.value =
                                      !controllerSignUpSteps
                                          .isCheckedAnimals.value;
                                  if (controllerSignUpSteps
                                      .isCheckedAnimals.value) {
                                    controllerSignUpSteps.interests
                                        .add("animals");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("animals");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Animals",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xffBAB8C5),
                                    width: 2,
                                  ),
                                  splashRadius: 0,
                                  value: controllerSignUpSteps
                                      .isCheckedEntertainment.value,
                                  onChanged: (bool? newValue) {
                                    controllerSignUpSteps.isCheckedEntertainment
                                        .value = newValue!;
                                    if (controllerSignUpSteps
                                        .isCheckedEntertainment.value) {
                                      controllerSignUpSteps.interests
                                          .add("entertainment");
                                    } else {
                                      controllerSignUpSteps.interests
                                          .remove("entertainment");
                                    }
                                  },
                                  activeColor: const Color(0xffBAB8C5),
                                  checkColor: AppColor.thirdColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerSignUpSteps
                                          .isCheckedEntertainment.value =
                                      !controllerSignUpSteps
                                          .isCheckedEntertainment.value;
                                  if (controllerSignUpSteps
                                      .isCheckedEntertainment.value) {
                                    controllerSignUpSteps.interests
                                        .add("entertainment");
                                  } else {
                                    controllerSignUpSteps.interests
                                        .remove("entertainment");
                                  }
                                },
                                child: SizedBox(
                                  child: TextWidget(
                                      "Entertainment",
                                      AppColor.forthColor,
                                      11.0,
                                      FontWeight.w400,
                                      0.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(
                        () => Visibility(
                          visible:
                              controllerSignUpSteps.interesrVisibility.value,
                          child: TextWidget(
                              "You have to select at least one interest",
                              Colors.redAccent,
                              10.0,
                              FontWeight.w400,
                              0.2),
                        ),
                      ),
                    ],
                  ),
                  //END TYPE OF EVENTS********************************************
                  //**********************************************************
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(
                            color: Color(0xffBAB8C5),
                            width: 2,
                          ),
                          splashRadius: 0,
                          value: controllerSignUpSteps.isCheckedOver18.value,
                          onChanged: (bool? newValue) {
                            controllerSignUpSteps.isCheckedOver18.value =
                                newValue!;
                          },
                          activeColor: const Color(0xffBAB8C5),
                          checkColor: AppColor.thirdColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controllerSignUpSteps.isCheckedOver18.value =
                              !controllerSignUpSteps.isCheckedOver18.value;
                        },
                        child: SizedBox(
                          child: TextWidget(
                              "I confirm I am over 18 years of age",
                              AppColor.forthColor,
                              11.0,
                              FontWeight.w400,
                              0.0),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Visibility(
                      visible: controllerSignUpSteps.overageVisibility.value,
                      child: TextWidget("You must be over 18", Colors.redAccent,
                          10.0, FontWeight.w400, 0.2),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonNext(SizeScreen.width * 0.85, SizeScreen.height * 0.065,
                      () {
                    if (controllerSignUpSteps.interests.isNotEmpty &&
                        controllerSignUpSteps.interesrVisibility.value ==
                            true) {
                      controllerSignUpSteps.interesrVisibility.value = false;
                    }
                    if (controllerSignUpSteps.email.value.isEmpty ||
                        controllerSignUpSteps.firstName.value.isEmpty ||
                        controllerSignUpSteps.lastName.value.isEmpty) {
                      snackbar(context, 1, "You have to fill all the fields!",
                          Colors.redAccent);
                    } else if (controllerSignUpSteps.interests.isEmpty) {
                      controllerSignUpSteps.interesrVisibility.value = true;
                    } else if (controllerSignUpSteps.isCheckedOver18.value ==
                        false) {
                      controllerSignUpSteps.overageVisibility.value = true;
                    } else {
                      Get.toNamed("/signinsteptwo");
                    }
                  }, AppColor.primaryColor, "Next")
                ],
              ),
            ),
          )),
    );
  }
}

final ControllerSignUpSteps controllerSignUpSteps =
    Get.find<ControllerSignUpSteps>();

// SizedBox(
//   height: Size.height * 0.08,
//   width: Size.width * 0.5,
//   child: DropdownButton<String>(
//     isExpanded: true,
//     underline: const Padding(
//       padding: EdgeInsets.only(top: 0.0),
//       child: Divider(
//         color: Colors.grey, // Customize the color as needed
//         thickness: 1, // Customize the thickness as needed
//       ),
//     ),
//     style: const TextStyle(
//       color: Color(0xffF6F6F6),
//       fontSize: 15,
//     ),
//     value: selectedOption, // Current selected option
//     icon: const Icon(Icons.arrow_drop_down,
//         color: Color(0xffF6F6F6)),
//     onChanged: (newValue) {
//       setState(() {
//         selectedOption =
//             newValue!; // Update the selected option
//       });
//     },
//     dropdownColor: const Color(0xff0F0E30),
//     items:
//         options.map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(
//           value,
//           style: const TextStyle(
//             color: Color(0xffF6F6F6),
//             fontSize: 15,
//           ),
//         ),
//       );
//     }).toList(),
//   ),
// ),
