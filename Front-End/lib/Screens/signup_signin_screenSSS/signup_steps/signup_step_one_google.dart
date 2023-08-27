import 'package:Bloc/Screens/signup_signin_screenSSS/signup_steps/controller/signup_google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/button_next.dart';
import '../../../component/text_widget.dart';
import '../../../constants.dart';

class SignUpStepOneGoogle extends StatelessWidget {
  const SignUpStepOneGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerSignUpStepsGoogle controllerSignUpStepsgoogle =
        Get.put(ControllerSignUpStepsGoogle());
    final Map<String, dynamic> arguments = Get.arguments;
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: appBar,
          backgroundColor: AppColor.mainColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      TextWidget("Enter your details", const Color(0xffF6F6F6),
                          22.0, FontWeight.w400, 0.5),
                      const SizedBox(height: 30),

                      // const SizedBox(height: 50),
                      TextWidget("Distance from your location",
                          const Color(0xffF6F6F6), 17.0, FontWeight.w300, 0.2),
                      const SizedBox(height: 5),
                      TextWidget(
                          "select the distance of events from your location",
                          Colors.grey,
                          11.0,
                          FontWeight.w300,
                          0.0),
                      const SizedBox(height: 15),
                      SliderTheme(
                        data: const SliderThemeData(
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 0.0, // Set the size of the overlay
                          ),
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
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
                                "${controllerSignUpStepsgoogle.distance.value.floor().toString()} Km",
                            min: 5,
                            max: 200,
                            value: controllerSignUpStepsgoogle.distance.value,
                            onChanged: (val) {
                              controllerSignUpStepsgoogle.UpdateDistance(val);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedSports.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedSports.value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedSports.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("sports");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("sports");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedSports.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedSports.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedSports.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("sports");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedArts.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedArts.value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedArts.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("art");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("arts");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedArts.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedArts.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedArts.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("arts");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
                                            .remove("arts");
                                      }
                                    },
                                    child: SizedBox(
                                      child: TextWidget(
                                          "Arts",
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedEducation.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedEducation
                                            .value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedEducation.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("education");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("education");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedEducation.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedEducation.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedEducation.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("education");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedFamily.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedFamily.value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedFamily.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("family");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("family");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedFamily.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedFamily.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedFamily.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("family");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedBusiness.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedBusiness
                                            .value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedBusiness.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("business");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("business");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedBusiness.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedBusiness.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedBusiness.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("business");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedAnimals.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedAnimals.value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedAnimals.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("animals");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("animals");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedAnimals.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedAnimals.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedAnimals.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("animals");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                                      value: controllerSignUpStepsgoogle
                                          .isCheckedEntertainment.value,
                                      onChanged: (bool? newValue) {
                                        controllerSignUpStepsgoogle
                                            .isCheckedEntertainment
                                            .value = newValue!;
                                        if (controllerSignUpStepsgoogle
                                            .isCheckedEntertainment.value) {
                                          controllerSignUpStepsgoogle.interests
                                              .add("entertainment");
                                        } else {
                                          controllerSignUpStepsgoogle.interests
                                              .remove("entertainment");
                                        }
                                      },
                                      activeColor: const Color(0xffBAB8C5),
                                      checkColor: AppColor.thirdColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controllerSignUpStepsgoogle
                                              .isCheckedEntertainment.value =
                                          !controllerSignUpStepsgoogle
                                              .isCheckedEntertainment.value;
                                      if (controllerSignUpStepsgoogle
                                          .isCheckedEntertainment.value) {
                                        controllerSignUpStepsgoogle.interests
                                            .add("entertainment");
                                      } else {
                                        controllerSignUpStepsgoogle.interests
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
                              visible: controllerSignUpStepsgoogle
                                  .interesrVisibility.value,
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
                      //const SizedBox(height: 25),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            value: controllerSignUpStepsgoogle
                                .isCheckedOver18.value,
                            onChanged: (bool? newValue) {
                              controllerSignUpStepsgoogle
                                  .isCheckedOver18.value = newValue!;
                            },
                            activeColor: const Color(0xffBAB8C5),
                            checkColor: AppColor.thirdColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controllerSignUpStepsgoogle.isCheckedOver18.value =
                                !controllerSignUpStepsgoogle
                                    .isCheckedOver18.value;
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
                        visible:
                            controllerSignUpStepsgoogle.overageVisibility.value,
                        child: TextWidget("You must be over 18",
                            Colors.redAccent, 10.0, FontWeight.w400, 0.2),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonNext(
                        SizeScreen.width * 0.85, SizeScreen.height * 0.065, () {
                      if (controllerSignUpStepsgoogle.interests.isNotEmpty &&
                          controllerSignUpStepsgoogle
                                  .interesrVisibility.value ==
                              true) {
                        controllerSignUpStepsgoogle.interesrVisibility.value =
                            false;
                      }
                      if (controllerSignUpStepsgoogle.interests.isEmpty) {
                        controllerSignUpStepsgoogle.interesrVisibility.value =
                            true;
                      } else if (controllerSignUpStepsgoogle
                              .isCheckedOver18.value ==
                          false) {
                        controllerSignUpStepsgoogle.overageVisibility.value =
                            true;
                      } else {
                        controllerSignUpStepsgoogle.finshingAccountCreation(
                            context,
                            arguments["access_token"],
                            arguments["refresh_token"]);
                      }
                    }, AppColor.primaryColor, "Next"),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
