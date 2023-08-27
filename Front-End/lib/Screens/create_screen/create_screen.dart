import 'dart:convert';
import 'dart:io';
import 'package:Bloc/Screens/signup_signin_screenSSS/signup_steps/signup_step_one.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../component/button_next.dart';
import '../../component/snack_bar.dart';
import '../../component/text_field.dart';
import '../../component/text_widget.dart';
import '../../constants.dart';
import 'controller/controller_create_screen.dart';
import 'package:intl/intl.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? image;

    ///TODO DELETE LATER

    final ControllerCreateScreen controllerCreateScreen =
        Get.find<ControllerCreateScreen>();
    TextEditingController controllerEventName =
        TextEditingController(text: controllerCreateScreen.eventName.value);
    TextEditingController controllerEventLink =
        TextEditingController(text: controllerCreateScreen.eventLink.value);
    TextEditingController controllerLocalisation =
        TextEditingController(text: controllerCreateScreen.localisation.value);
    TextEditingController controllerStartDate =
        TextEditingController(text: controllerCreateScreen.startDate.value);
    TextEditingController controllerEndDate =
        TextEditingController(text: controllerCreateScreen.endDate.value);
    TextEditingController controllerStartTime =
        TextEditingController(text: controllerCreateScreen.startTime.value);
    TextEditingController controllerEndTime =
        TextEditingController(text: controllerCreateScreen.endTime.value);
    TextEditingController controllerPhoto =
        TextEditingController(text: controllerCreateScreen.photo.value);

    List<String> options = [
      'Type of Events',
      'Sports',
      'Arts',
      'Entertainment',
      'Family',
      "Business",
      "Animals",
      "Education"
    ];

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        height: SizeScreen.height * 0.94,
        decoration: const BoxDecoration(
          color: AppColor.mainColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              TextWidget("Create event", AppColor.forthColor, 18.0,
                  FontWeight.w700, 0.2),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget("Event name", AppColor.forthColor, 11.0,
                      FontWeight.w300, 0.1),
                  TextFieldWidget(
                    controller: controllerEventName,
                    (String ch) {
                      controllerCreateScreen.eventName.value = ch;
                    },
                    TextInputType.text,
                    'NYC POWERLIFTING COMPETITION 2023',
                  ),
                  // LOCATION
                  const SizedBox(height: 25),
                  TextWidget("Location", AppColor.forthColor, 11.0,
                      FontWeight.w300, 0.1),
                  GestureDetector(
                    onTap: () async {
                      controllerCreateScreen.localisation.value =
                          await Get.toNamed('/map', arguments: {
                        "lat": controllerSignUpSteps.latitude,
                        "long": controllerSignUpSteps.longitude,
                      });
                      if (controllerCreateScreen.localisation.value != "") {
                        controllerLocalisation.text =
                            controllerCreateScreen.localisation.value;
                      }
                    },
                    child: TextFieldWidget(
                      enabled: false,
                      controller: controllerLocalisation,
                      (String ch) {},
                      TextInputType.text,
                      'Madison Square Garden',
                      inputdecoration: KinputDecoration.copyWith(
                        hintText: 'Madison Square Garden',
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  //EVENT DATE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget("Start date", AppColor.forthColor, 11.0,
                                FontWeight.w300, 0.1),
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  locale: const Locale("en", "EN"),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  currentDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                );
                                if (pickedDate != null) {
                                  controllerCreateScreen.startDate.value =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  controllerStartDate.text =
                                      controllerCreateScreen.startDate.value;
                                }
                              },
                              child: TextFieldWidget(
                                controller: controllerStartDate,
                                (String ch) {},
                                TextInputType.text,
                                '07/08/2023',
                                inputdecoration: KinputDecoration.copyWith(
                                  hintText: '07/08/2023',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  suffixIcon: const SizedBox(
                                    width: 0,
                                    height: 10,
                                    child: Icon(
                                      opticalSize: 0.1,
                                      FontAwesomeIcons.calendar,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget("End date", AppColor.forthColor, 11.0,
                                FontWeight.w300, 0.1),
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  locale: const Locale("en", "EN"),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  currentDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                );
                                if (pickedDate != null) {
                                  controllerCreateScreen.endDate.value =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  controllerEndDate.text =
                                      controllerCreateScreen.endDate.value;
                                }
                              },
                              child: TextFieldWidget(
                                controller: controllerEndDate,
                                (String ch) {},
                                TextInputType.text,
                                '10/08/2023',
                                inputdecoration: KinputDecoration.copyWith(
                                  hintText: '10/08/2023',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  suffixIcon: const SizedBox(
                                    width: 0,
                                    height: 10,
                                    child: Icon(
                                      opticalSize: 0.1,
                                      FontAwesomeIcons.calendar,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget("Start time", AppColor.forthColor, 11.0,
                                FontWeight.w300, 0.1),
                            GestureDetector(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controllerCreateScreen.startTime.value =
                                      pickedTime.format(context);
                                  controllerStartTime.text =
                                      "${pickedTime.format(context)} Pm";
                                }
                              },
                              child: TextFieldWidget(
                                  controller: controllerStartTime,
                                  enabled: false,
                                  (String ch) {},
                                  TextInputType.text,
                                  '6 Pm',
                                  inputdecoration: KinputDecoration.copyWith(
                                    hintText: '6 Pm',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    suffixIcon: const SizedBox(
                                      width: 0,
                                      height: 10,
                                      child: Icon(
                                        opticalSize: 0.1,
                                        FontAwesomeIcons.clock,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget("EndTime", AppColor.forthColor, 11.0,
                                FontWeight.w300, 0.1),
                            GestureDetector(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controllerCreateScreen.endTime.value =
                                      pickedTime.format(context);
                                  controllerEndTime.text =
                                      "${pickedTime.format(context)} Pm";
                                }
                              },
                              child: TextFieldWidget(
                                  controller: controllerEndTime,
                                  enabled: false,
                                  (String ch) {},
                                  TextInputType.text,
                                  '10 Pm',
                                  inputdecoration: KinputDecoration.copyWith(
                                    hintText: '10 Pm',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    suffixIcon: const SizedBox(
                                      width: 0,
                                      height: 10,
                                      child: Icon(
                                        opticalSize: 0.1,
                                        FontAwesomeIcons.clock,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  //EVENT TYPE
                  TextWidget("Event type", AppColor.forthColor, 11.0,
                      FontWeight.w300, 0.1),
                  SizedBox(
                    height: SizeScreen.height * 0.08,
                    width: SizeScreen.width * 0.5,
                    child: Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        underline: const Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Divider(
                            color: Colors.grey, // Customize the color as needed
                            thickness: 1, // Customize the thickness as needed
                          ),
                        ),
                        style: const TextStyle(
                          color: Color(0xffF6F6F6),
                          fontSize: 15,
                        ),
                        value: controllerCreateScreen
                            .eventType.value, // Current selected option
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Color(0xffF6F6F6)),
                        onChanged: (newValue) {
                          controllerCreateScreen.eventType.value = newValue!;
                        },
                        dropdownColor: const Color(0xff0F0E30),
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Event PHOTO
                  TextWidget("Event photo", AppColor.forthColor, 11.0,
                      FontWeight.w300, 0.1),
                  GestureDetector(
                    onTap: () async {
                      final image = await requestStoragePermission();
                      final img = File(image.path);
                      controllerCreateScreen.base64 =
                          base64Encode(img.readAsBytesSync());
                      String fileName = img.path.split('/').last;
                      controllerCreateScreen.photo.value = fileName.length > 50
                          ? fileName.substring(0, 30)
                          : fileName;
                      controllerPhoto.text = controllerCreateScreen.photo.value;
                    },
                    child: TextFieldWidget(
                        controller: controllerPhoto,
                        enabled: false,
                        (String ch) {},
                        TextInputType.text,
                        'NBA_Event.png',
                        inputdecoration: KinputDecoration.copyWith(
                          hintText: 'NBA_Event.png',
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
                  ),

                  const SizedBox(height: 25),
                  // Event LINK
                  TextWidget("Event link", AppColor.forthColor, 11.0,
                      FontWeight.w300, 0.1),
                  TextFieldWidget(
                    controller: controllerEventLink,
                    (String ch) {
                      controllerCreateScreen.eventLink.value = ch;
                    },
                    TextInputType.text,
                    'https://nyc.maps.arcgis.com/apps/instant/sli...',
                  ),
                  SizedBox(height: 25),
                  TextWidget(
                      "select the distance from event for who this is available to",
                      AppColor.forthColor,
                      11.0,
                      FontWeight.w300,
                      0.1),
                  const SizedBox(
                    height: 15,
                  ),
                  SliderTheme(
                    data: const SliderThemeData(
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 0.0, // Set the size of the overlay
                      ),
                      valueIndicatorShape:
                          PaddleSliderValueIndicatorShape(), // Set the value indicator shape
                      showValueIndicator:
                          ShowValueIndicator.always, // Show the value indicator
                      trackHeight: 1.5,
                      // rangeThumbShape: RangeSliderThumbShape(),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8.0,
                        pressedElevation: 100,
                      ),
                      valueIndicatorTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    child: Obx(
                      () => Slider(
                        label:
                            "${controllerCreateScreen.distance.value.floor().toString()} Km",
                        min: 2,
                        max: 200,
                        value: controllerCreateScreen.distance.value,
                        onChanged: (val) {
                          controllerCreateScreen.distance.value = val;
                        },
                        thumbColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => ButtonNext(
                        SizeScreen.width * 0.3,
                        SizeScreen.height * 0.046,
                        controllerCreateScreen.isLoading.value == false
                            ? () {
                                bool verif =
                                    controllerCreateScreen.ControlVerification(
                                        context);
                                if (verif == false) {
                                  snackbar(
                                      context,
                                      1,
                                      "You have to fill all the fields",
                                      Colors.redAccent);
                                } else {
                                  controllerCreateScreen.createEvent(context);
                                }
                              }
                            : null,
                        AppColor.secondaryColor,
                        controllerCreateScreen.isLoading.value == false
                            ? "Create"
                            : "wait...",
                        circularRadious: 8.0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future requestStoragePermission() async {
  var status = await Permission.storage.request();

  if (status.isGranted) {
    final image = await pickImage();
    print("rrrrrrrrrrrrrrrrrrrrrrrrr ${image.runtimeType}");
    return image;
  } else if (status.isDenied) {
    requestStoragePermission();
  } else if (status.isPermanentlyDenied) {
    requestStoragePermission();
    openAppSettings();
  }
}

Future pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;

  return image;
}
