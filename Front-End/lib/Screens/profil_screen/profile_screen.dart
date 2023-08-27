import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/button_next.dart';
import '../../component/text_field.dart';
import '../../component/text_widget.dart';
import '../../constants.dart';
import '../home_screen/shimmer loading.dart';
import 'controller/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerProfile controllerProfile = Get.put(ControllerProfile());
    return Scaffold(
      backgroundColor: AppColor.forthColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.mainColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                TextWidget("My Account", AppColor.forthColor, 18.0,
                    FontWeight.w700, 0.2),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //----Name
                    TextWidget("Name", AppColor.forthColor, 11.0,
                        FontWeight.w300, 0.1),
                    FutureBuilder(
                      future: controllerProfile.futureProfile,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const ShimmerHome3();
                        } else {
                          return TextFieldWidget(
                              enabled: false,
                              (String ch) {},
                              TextInputType.text,
                              "${controllerProfile.profile.firstName} ${controllerProfile.profile.lastName}");
                        }
                      },
                    ),
                    // Phone Number
                    const SizedBox(height: 25),
                    TextWidget("Email", AppColor.forthColor, 11.0,
                        FontWeight.w300, 0.1),
                    FutureBuilder(
                      future: controllerProfile.futureProfile,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const ShimmerHome3();
                        } else {
                          return TextFieldWidget(
                            (String ch) {},
                            TextInputType.text,
                            controllerProfile.profile.username,
                            enabled: false,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 25),
                    //-----Password
                    TextWidget("Password", AppColor.forthColor, 11.0,
                        FontWeight.w300, 0.1),
                    TextFieldWidget(
                        enabled: false,
                        (String ch) {},
                        TextInputType.text,
                        '****************'),
                    const SizedBox(height: 25),
                    //------My Events
                    TextWidget("My events", AppColor.forthColor, 11.0,
                        FontWeight.w300, 0.1),
                    TextFieldWidget((String ch) {}, TextInputType.text, '6 Pm',
                        inputdecoration: KinputDecoration.copyWith(
                          hintText: 'My events',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 13),
                          suffixIcon: const SizedBox(
                            width: 0,
                            height: 10,
                            child: Icon(
                              opticalSize: 0.1,
                              FontAwesomeIcons.chevronRight,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(height: 25),
                    //Distance
                    TextWidget("Distance from your location",
                        AppColor.forthColor, 11.0, FontWeight.w300, 0.0),
                    const SizedBox(height: 15),
                    FutureBuilder(
                      future: controllerProfile.futureProfile,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const Center(
                            child: ShimmerHome3(),
                          );
                        } else {
                          return SliderTheme(
                            data: const SliderThemeData(
                              overlayShape: RoundSliderOverlayShape(
                                overlayRadius:
                                    0.0, // Set the size of the overlay
                              ),

                              valueIndicatorShape:
                                  PaddleSliderValueIndicatorShape(), // Set the value indicator shape
                              showValueIndicator: ShowValueIndicator
                                  .always, // Show the value indicator
                              trackHeight: 1.5,
                              // rangeThumbShape: RangeSliderThumbShape(),
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 8.0,
                                pressedElevation: 0,
                              ),
                            ),
                            child: Slider(
                              //label: "${ValSlider.toString()} Km",
                              min: 2,
                              max: 200,
                              value: controllerProfile.profile.distance!.value
                                  .toDouble(),
                              onChanged: (val) {},
                              thumbColor: Colors.white,
                              activeColor: Colors.white,
                              inactiveColor: Colors.grey,
                            ),
                          );
                        }
                      },
                    ),
                    //EVENT TYPE
                    const SizedBox(height: 25),
                    TextWidget("Events that i'm interested in",
                        AppColor.forthColor, 11.0, FontWeight.w300, 0.1),
                    //EVENTS TYPES *******************
                    FutureBuilder(
                      future: controllerProfile.futureProfile,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData &&
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const Center(
                            child: ShimmerHome3(),
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('sports'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("sports");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("sports");
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('arts'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("arts");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile.addCategory("arts");
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('education'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("education");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("education");
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('family'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("family");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("family");
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('business'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("business");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("business");
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
                                      FutureBuilder(
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (!snapshot.hasData &&
                                              snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                            return const ShimmerHome3();
                                          } else {
                                            return Obx(
                                              () => Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                side: const BorderSide(
                                                  color: Color(0xffBAB8C5),
                                                  width: 2,
                                                ),
                                                splashRadius: 0,
                                                value: controllerProfile
                                                    .isChecked('animals'),
                                                onChanged: (bool? newValue) {
                                                  controllerProfile
                                                      .addCategory("animals");
                                                },
                                                activeColor:
                                                    const Color(0xffBAB8C5),
                                                checkColor: AppColor.thirdColor,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("animals");
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xffBAB8C5),
                                            width: 2,
                                          ),
                                          splashRadius: 0,
                                          value: controllerProfile
                                              .isChecked('entertainment'),
                                          onChanged: (bool? newValue) {
                                            controllerProfile
                                                .addCategory("entertainment");
                                          },
                                          activeColor: const Color(0xffBAB8C5),
                                          checkColor: AppColor.thirdColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controllerProfile
                                              .addCategory("entertainment");
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
                                  visible: controllerProfile
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
                          );
                        }
                      },
                    ),
                    //END EVENTS TYPES *******************
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ButtonNext(
                      SizeScreen.width * 0.4, SizeScreen.height * 0.053,
                      () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('AccessToken');
                    prefs.remove('RefreshToken');
                    Get.offNamed('signinsignup');
                  }, AppColor.secondaryColor, "Log out", circularRadious: 8.0),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
