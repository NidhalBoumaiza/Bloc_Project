import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../component/button_next.dart';
import '../../component/date_time_widget.dart';
import '../../component/text_widget.dart';
import '../../constants.dart';
import '../home_screen/controller/controller_home.dart';
//import '../../Screens/home_screen/models/Event.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerHome controllerHome = Get.find<ControllerHome>();
    final Map<String, dynamic> arguments = Get.arguments;
    var index = controllerHome.events.indexWhere((element) {
      return element.id == arguments["id"];
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SvgPicture.string(appLogo),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              //ImageContainerWidget-----------
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                  border: Border.all(
                    color: Colors.blue, // Replace with the color you want
                    width: 1.0, // Adjust the border width as needed
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                  child: Hero(
                    tag: 1,
                    child: Image.network(
                      "$URL${arguments["picture"]}", // Replace with your image path
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextWidget(arguments["name"], AppColor.secondaryColor, 16.0,
                  FontWeight.w600, 0.2),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget("Location:", const Color(0xff5C596D), 17.0,
                      FontWeight.w700, 0.2),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: controllerHome.isLiking.value == false
                            ? () async {
                                controllerHome.like(arguments['id'], "dislike",
                                    arguments['like'], index);
                              }
                            : null,
                        child: Obx(
                          () => controllerHome.events[index].like?.value == 0 ||
                                  controllerHome.events[index].like?.value == 1
                              ? SvgPicture.string(arrowWhiteDown)
                              : SvgPicture.string(arrowBlueDown),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => TextWidget(
                            controllerHome.events[index].score?.value
                                .toString(),
                            AppColor.forthColor,
                            13.0,
                            FontWeight.w600,
                            0.02),
                      ),
                      const SizedBox(width: 10),

                      ///TODO LATER ARROW WHITE UP
                      GestureDetector(
                          onTap: controllerHome.isLiking.value == false
                              ? () async {
                                  controllerHome.like(arguments['id'], "like",
                                      arguments['like'], index);
                                }
                              : null,
                          child: Obx(
                            () => controllerHome.events[index].like?.value ==
                                        0 ||
                                    controllerHome.events[index].like?.value ==
                                        -1
                                ? SvgPicture.string(arrowWhiteUp)
                                : SvgPicture.string(arrowBlueUp),
                          )),
                    ],
                  ),
                  //ADD rating
                ],
              ),
              const SizedBox(height: 15),
              TextWidget(
                arguments["location_name"],
                AppColor.forthColor,
                12.00,
                FontWeight.w500,
                0.0,
              ),
              const SizedBox(height: 20),
              DateTimeWidget("${arguments["startDate"]}",
                  "${arguments["startTime"]} - ${arguments["endTime"]}"),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: SvgPicture.string(share),
                    onTap: () async {
                      ///TODO LATER

                      await Share.share('check out this event!',
                          subject: arguments["link"]);
                    },
                  ),
                  GestureDetector(
                    child: SvgPicture.string(report),
                    onTap: () {
                      ///TODO LATER
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ButtonNext(
                    SizeScreen.width * 0.9, SizeScreen.height * 0.065, () {
                  ///TODO Later
                }, AppColor.secondaryColor, "Buy tickets"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
