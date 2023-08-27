import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../component/button_next.dart';
import '../../../component/snack_bar.dart';
import '../../../component/text_field.dart';
import '../../../component/text_widget.dart';
import '../../../constants.dart';
import 'controller/signup_steps_controller.dart';

class SignUpStepTwo extends StatelessWidget {
  const SignUpStepTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerSignUpSteps controllerSignUpSteps =
        Get.find<ControllerSignUpSteps>();
    TextEditingController controllerpassword =
        TextEditingController(text: controllerSignUpSteps.password.value);
    TextEditingController controllerconfirmpassword = TextEditingController(
        text: controllerSignUpSteps.confirmPassword.value);

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
                    child: Obx(
                      () => TextFieldWidget(
                        (String ch) {
                          controllerSignUpSteps.password.value = ch;
                        },
                        TextInputType.emailAddress,
                        "Password",
                        controller: controllerpassword,
                        obsecuretext:
                            controllerSignUpSteps.passwordVisibility.value,
                        inputdecoration: KinputDecoration.copyWith(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          suffixIcon:
                              controllerSignUpSteps.passwordVisibility.value
                                  ? IconButton(
                                      splashRadius: 1,
                                      icon: Icon(
                                        FontAwesomeIcons.eye,
                                        size: 18,
                                      ),
                                      color: Colors.grey,
                                      onPressed: () {
                                        controllerSignUpSteps
                                                .passwordVisibility.value =
                                            !controllerSignUpSteps
                                                .passwordVisibility.value;
                                      },
                                    )
                                  : IconButton(
                                      splashRadius: 1,
                                      icon: Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        size: 18,
                                      ),
                                      color: Colors.grey,
                                      onPressed: () {
                                        controllerSignUpSteps
                                                .passwordVisibility.value =
                                            !controllerSignUpSteps
                                                .passwordVisibility.value;
                                      },
                                    ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => TextFieldWidget(
                        (String ch) {
                          controllerSignUpSteps.confirmPassword.value = ch;
                        },
                        TextInputType.emailAddress,
                        "Confirm Password",
                        controller: controllerconfirmpassword,
                        obsecuretext: controllerSignUpSteps
                            .confirmpasswordVisibility.value,
                        inputdecoration: KinputDecoration.copyWith(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          suffixIcon: controllerSignUpSteps
                                  .confirmpasswordVisibility.value
                              ? IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.eye,
                                    size: 18,
                                  ),
                                  color: Colors.grey,
                                  onPressed: () {
                                    controllerSignUpSteps
                                            .confirmpasswordVisibility.value =
                                        !controllerSignUpSteps
                                            .confirmpasswordVisibility.value;
                                  },
                                )
                              : IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    size: 18,
                                  ),
                                  color: Colors.grey,
                                  onPressed: () {
                                    controllerSignUpSteps
                                            .confirmpasswordVisibility.value =
                                        !controllerSignUpSteps
                                            .confirmpasswordVisibility.value;
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeScreen.height * 0.49),
                  ButtonNext(
                      SizeScreen.width * 0.85,
                      SizeScreen.height * 0.065,
                      controllerSignUpSteps.isLoadingStepTwo.value == false
                          ? () async {
                              if (controllerSignUpSteps
                                      .password.value.isEmpty ||
                                  controllerSignUpSteps
                                      .confirmPassword.value.isEmpty ||
                                  (controllerSignUpSteps.password.value !=
                                      controllerSignUpSteps
                                          .confirmPassword.value)) {
                                snackbar(
                                    context,
                                    1,
                                    'You have to confirm your password',
                                    Colors.redAccent);
                              } else if (controllerSignUpSteps
                                      .password.value.length <
                                  8) {
                                snackbar(
                                    context,
                                    1,
                                    'You password should be more than 7 characters',
                                    Colors.redAccent);
                              } else {
                                controllerSignUpSteps.isLoadingStepTwo.value =
                                    true;
                                var data = {
                                  "email": controllerSignUpSteps.email.value,
                                  "password":
                                      controllerSignUpSteps.password.value,
                                  "confirm_password": controllerSignUpSteps
                                      .confirmPassword.value,
                                  "first_name":
                                      controllerSignUpSteps.firstName.value,
                                  "last_name":
                                      controllerSignUpSteps.lastName.value,
                                  "distance": controllerSignUpSteps
                                      .distance.value
                                      .floor(),
                                  "prefered_categories":
                                      controllerSignUpSteps.interests
                                };
                                var body = jsonEncode(data);
                                var res = await http.post(
                                  Uri.parse("$URL/auth/register/"),
                                  headers: {
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: body,
                                );

                                var decodedResponse = jsonDecode(res.body);
                                if (res.statusCode == 200) {
                                  controllerSignUpSteps.isLoadingStepTwo.value =
                                      false;
                                  // print(decodedResponse);
                                  Get.offNamed("/signinscreen");
                                } else {
                                  controllerSignUpSteps.isLoadingStepTwo.value =
                                      false;
                                  snackbar(context, 2, decodedResponse,
                                      Colors.redAccent);
                                }
                              }
                            }
                          : null,
                      AppColor.primaryColor,
                      controllerSignUpSteps.isLoadingStepTwo.value == false
                          ? "Finish account creation"
                          : "Please wait")
                ],
              ),
            ),
          )),
    );
  }
}
