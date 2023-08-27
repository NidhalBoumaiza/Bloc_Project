import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../component/animationText.dart';
import '../../../component/button_next.dart';
import '../../../component/text_widget.dart';
import '../../../constants.dart';
import '../../../function_get_location.dart';
import 'controller/signup_steps_controller.dart';

class SignUpStepThree extends StatefulWidget {
  const SignUpStepThree({Key? key}) : super(key: key);

  @override
  State<SignUpStepThree> createState() => _SignUpStepThreeState();
}

class _SignUpStepThreeState extends State<SignUpStepThree> {
  bool _showWidget1 = false;
  bool _showWidget2 = false;
  bool _showWidget3 = false;
  bool _showWidget4 = false;

  @override
  void initState() {
    super.initState();
    _showWidgetsOneByOne();
  }

  // final dynamic arguments = Get.arguments;

  final ControllerSignUpSteps controllerSignUpSteps =
      Get.find<ControllerSignUpSteps>();
  void _showWidgetsOneByOne() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _showWidget1 = true;
      });
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showWidget2 = true;
      });
    });

    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showWidget3 = true;
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showWidget4 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            // extendBodyBehindAppBar: true,
            // appBar: arguments != null ? null : appBar,
            backgroundColor: AppColor.mainColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Stack(
                      children: [
                        Image.asset('images/maponly.png'),
                        Positioned(
                          left: SizeScreen.width * 0.19,
                          top: SizeScreen.height * 0.05,
                          child: Visibility(
                            visible: _showWidget1,
                            child: AnimationFindIn(
                              child: Image.asset('images/1.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: SizeScreen.width * 0.52,
                          top: SizeScreen.height * 0.08,
                          child: Visibility(
                            visible: _showWidget2,
                            child: AnimationFindIn(
                              child: Image.asset('images/2.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: SizeScreen.width * 0.17,
                          top: SizeScreen.height * 0.21,
                          child: Visibility(
                            visible: _showWidget3,
                            child: AnimationFindIn(
                              child: Image.asset('images/3.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: SizeScreen.width * 0.52,
                          top: SizeScreen.height * 0.23,
                          child: Visibility(
                            visible: _showWidget4,
                            child: AnimationFindIn(
                              child: Image.asset('images/4.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: TextWidget("Enable Location",
                          const Color(0xff8A8899), 20.0, FontWeight.w400, 0.0),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: TextWidget(
                          "Allow bloc to access your location? You must allow access for bloc to work. We will only track your location while on duty.",
                          const Color(0xff8A8899),
                          12.0,
                          FontWeight.w400,
                          0.0,
                          textalign: TextAlign.center),
                    ),
                    SizedBox(height: SizeScreen.height * 0.147),
                    Obx(
                      () => ButtonNext(
                          SizeScreen.width * 0.85,
                          SizeScreen.height * 0.065,
                          controllerSignUpSteps.stepthreeLoading.value == false
                              ? () async {
                                  controllerSignUpSteps.stepthreeLoading.value =
                                      true;
                                  getCurrentLocation(context);
                                }
                              : null,
                          AppColor.primaryColor,
                          controllerSignUpSteps.stepthreeLoading.value == true
                              ? "Wait..."
                              : "Start"),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
