import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/button_next.dart';
import '../../../component/text_field.dart';
import '../../../constants.dart';
import 'controller/controller_signin.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerSignIn = Get.put(ControllerSignIn());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 120),
                Center(child: Image.asset("images/logo.png")),
                const SizedBox(height: 50),
                TextFieldWidget((String ch) {
                  controllerSignIn.email = ch;
                }, TextInputType.emailAddress, "Email"),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => TextFieldWidget(
                      (String ch) {
                        controllerSignIn.password = ch;
                      },
                      TextInputType.emailAddress,
                      "Confirm Password",
                      obsecuretext: controllerSignIn.passwordVisibility.value,
                      inputdecoration: KinputDecoration.copyWith(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        suffixIcon: controllerSignIn.passwordVisibility.value
                            ? IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.eye,
                                  size: 18,
                                ),
                                color: Colors.grey,
                                onPressed: () {
                                  controllerSignIn.passwordVisibility.value =
                                      !controllerSignIn
                                          .passwordVisibility.value;
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  size: 18,
                                ),
                                color: Colors.grey,
                                onPressed: () {
                                  controllerSignIn.passwordVisibility.value =
                                      !controllerSignIn
                                          .passwordVisibility.value;
                                },
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Obx(
                  () => ButtonNext(
                      SizeScreen.width * 0.85,
                      SizeScreen.height * 0.065,
                      controllerSignIn.isLoading == false
                          ? () {
                              ///TODO Later
                              controllerSignIn.login(context);
                            }
                          : null,
                      AppColor.primaryColor,
                      controllerSignIn.isLoading == false
                          ? "Connect"
                          : "Wait..."),
                ),
                SizedBox(height: SizeScreen.height * 0.2),
                GestureDetector(
                  onTap: () {
                    ///TODO LATER
                    Get.back();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.roboto(color: AppColor.forthColor),
                        ),
                        TextSpan(
                          text: " Sign up",
                          style: GoogleFonts.roboto(
                              color: AppColor.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
