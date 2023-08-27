import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../component/animationText.dart';
import '../../constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: AnimationFindIn(
                    child: SvgPicture.string(bigAppLogo),
                  )),
                ],
              ),
              SizedBox(height: SizeScreen.height * 0.385),
              SizedBox(
                width: SizeScreen.width * 0.85,
                height: SizeScreen.height * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    ///TODO LATER
                    Get.toNamed("/signinsignup");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            color: AppColor.forthColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          FontAwesomeIcons.arrowRight,
                          color: AppColor.forthColor,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
