import 'package:Bloc/Screens/home_screen/shimmer%20loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import '../../component/event_home_component.dart';
import '../../component/text_widget.dart';
import '../../constants.dart';
import 'controller/controller_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerHome controllerHome = Get.find<ControllerHome>();

    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: controllerHome.getHomeEvents("partial"),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: ShimmerHome1());
                  } else {
                    return Obx(() => controllerHome.isLoading.value == false
                        ? controllerHome.events.isEmpty
                            ? const Center(
                                child: SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: Image(
                                    image: AssetImage("images/empty.jpg"),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  print(controllerHome.events[0].id);

                                  ///TODO LATER
                                  Get.toNamed("/detailsscreen", arguments: {
                                    "id": controllerHome.events[0].id,
                                    "name":
                                        controllerHome.events[0].name?.value,
                                    "location_name": controllerHome
                                        .events[0].locationName?.value,
                                    "picture":
                                        controllerHome.events[0].picture?.value,
                                    "startTime": DateFormat.jm().format(
                                        DateTime.parse(controllerHome
                                            .events[0].startDate!.value)),
                                    "endTime": DateFormat.jm().format(
                                        DateTime.parse(controllerHome
                                            .events[0].endDate!.value)),
                                    "link":
                                        controllerHome.events[0].link?.value,
                                    "picture":
                                        controllerHome.events[0].picture?.value,
                                    "startDate": DateFormat('EEEE, MMMM d, y')
                                        .format(DateTime.parse(controllerHome
                                            .events[0].startDate!.value)),
                                    "score":
                                        controllerHome.events[0].score?.value,
                                    "like":
                                        controllerHome.events[0].like?.value,
                                  });
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Hero(
                                        tag: 1,
                                        child: Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius as needed
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "$URL${controllerHome.events[0].picture?.value}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                      child: Container(
                                        height: SizeScreen.height * 0.085,
                                        width: double.infinity,
                                        color: Colors.grey.withOpacity(0.1),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                "${controllerHome.events[0].name?.value}",
                                                AppColor.forthColor
                                                    .withOpacity(0.7),
                                                14.0,
                                                FontWeight.w400,
                                                0.1,
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                      "",
                                                      AppColor.forthColor
                                                          .withOpacity(0.7),
                                                      9.0,
                                                      FontWeight.w300,
                                                      0.1),
                                                  TextWidget(
                                                      '${DateFormat.jm().format(DateTime.parse(controllerHome.events[0].startDate!.value))} - ${DateFormat.jm().format(DateTime.parse(controllerHome.events[0].endDate!.value))}',
                                                      AppColor.forthColor
                                                          .withOpacity(0.7),
                                                      9.0,
                                                      FontWeight.w300,
                                                      0.1),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                        : const Center(child: ShimmerHome1()));
                  }
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Other",
                        style: GoogleFonts.roboto(
                          color: AppColor.forthColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " Events",
                        style: GoogleFonts.roboto(
                          color: AppColor.forthColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ])),
                    GestureDetector(
                      onTap: () {
                        ///TODO LATER
                        // controllerHome.getHomeEvents("all");
                        Get.toNamed("/seeAll");
                      },
                      child: TextWidget("See All", AppColor.secondaryColor,
                          14.0, FontWeight.w700, 0.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FutureBuilder(
                  future: controllerHome.getHomeEvents("partial"),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: ShimmerHome2(),
                      );
                    } else {
                      return Obx(() => controllerHome.isLoading.value == false
                          ? controllerHome.events.length < 2
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: SizedBox(
                                        height: 180,
                                        width: 180,
                                        child: Image(
                                          image: AssetImage("images/empty.jpg"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextWidget(
                                      "No events available for now",
                                      AppColor.forthColor,
                                      15.0,
                                      FontWeight.w600,
                                      0.2,
                                    ),
                                  ],
                                )
                              : MasonryGridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 10,
                                  gridDelegate:
                                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: controllerHome.events.length - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        ///TODO LATER
                                        Get.toNamed("/detailsscreen",
                                            arguments: {
                                              "id": controllerHome
                                                  .events[index + 1].id,
                                              "name": controllerHome
                                                  .events[index + 1]
                                                  .name
                                                  ?.value,
                                              "location_name": controllerHome
                                                  .events[index + 1]
                                                  .locationName
                                                  ?.value,
                                              "picture": controllerHome
                                                  .events[index + 1]
                                                  .picture
                                                  ?.value,
                                              "startTime": DateFormat.jm()
                                                  .format(DateTime.parse(
                                                      controllerHome
                                                          .events[index + 1]
                                                          .startDate!
                                                          .value)),
                                              "endTime": DateFormat.jm().format(
                                                  DateTime.parse(controllerHome
                                                      .events[index + 1]
                                                      .endDate!
                                                      .value)),
                                              "link": controllerHome
                                                  .events[index + 1]
                                                  .link
                                                  ?.value,
                                              "picture": controllerHome
                                                  .events[index + 1]
                                                  .picture
                                                  ?.value,
                                              "startDate":
                                                  DateFormat('EEEE, MMMM d, y')
                                                      .format(DateTime.parse(
                                                          controllerHome
                                                              .events[0]
                                                              .startDate!
                                                              .value)),
                                              "score": controllerHome
                                                  .events[index + 1]
                                                  .score
                                                  ?.value,
                                              "like": controllerHome
                                                  .events[index + 1]
                                                  .like
                                                  ?.value,
                                            });
                                      },
                                      child: EventComponent(
                                        controllerHome
                                            .events[index + 1].picture?.value,
                                        controllerHome
                                            .events[index + 1].name?.value,
                                        controllerHome
                                            .events[index + 1].startDate?.value,
                                        controllerHome
                                            .events[index + 1].endDate?.value,
                                      ),
                                    );
                                    //Image.asset('images/picture${index}.png');
                                  },
                                )
                          : const Center(
                              child: ShimmerHome2(),
                            ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// GridView(
// physics: BouncingScrollPhysics(),
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2, // Number of columns
// crossAxisSpacing: 10.0, // Spacing between columns
//
// mainAxisSpacing: 0.0, // Spacing between rows
// childAspectRatio: 1, // Aspect ratio of each item (width/height)
// ),
// children: [
// Image.asset('images/picture5.png'),
// Image.asset('images/picture6.png'),
// Image.asset('images/picture7.png'),
// Image.asset('images/picture1.png'),
// Image.asset('images/picture3.png'),
// Image.asset('images/picture3.png'),
// ],
// )
