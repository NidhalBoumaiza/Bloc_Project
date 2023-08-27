import 'package:Bloc/Screens/home_screen/controller/controller_home.dart';
import 'package:Bloc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/event_home_component.dart';
import '../../component/text_widget.dart';
import '../home_screen/shimmer loading.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({Key? key}) : super(key: key);

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final ControllerHome controllerHome = Get.find<ControllerHome>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerHome.getHomeEvents("all");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        appBar: AppBar(
          // leading: const SizedBox.shrink(),
          title: Transform(
            transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
            child: SvgPicture.string(appLogo),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: RichText(
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
                    text: " Events:",
                    style: GoogleFonts.roboto(
                      color: AppColor.forthColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ])),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FutureBuilder(
                  future: controllerHome.getHomeEvents("all"),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: ShimmerHome2(),
                      );
                    } else {
                      print("${controllerHome.eventsAll.length}");
                      return Obx(
                        () => MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: controllerHome.eventsAll.length,
                          itemBuilder: (BuildContext context, int index) {
                            return EventComponent(
                              controllerHome.eventsAll[index].picture?.value,
                              controllerHome.eventsAll[index].name?.value,
                              controllerHome.eventsAll[index].startDate?.value,
                              controllerHome.eventsAll[index].endDate?.value,
                            );
                            //Image.asset('images/picture${index}.png');
                          },
                        ),
                      );
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
