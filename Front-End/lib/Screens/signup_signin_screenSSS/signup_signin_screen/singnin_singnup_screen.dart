import 'dart:convert';
import 'package:Bloc/component/snack_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../../../component/button_signin.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../signin_screen/controller/controller_signin.dart';

class SignupSingninScreen extends StatefulWidget {
  const SignupSingninScreen({Key? key}) : super(key: key);

  @override
  State<SignupSingninScreen> createState() => _SignupSingninScreenState();
}

class _SignupSingninScreenState extends State<SignupSingninScreen> {
  facebookLogin() async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
        print('1111111111111111111111111111');
        var t = await FacebookAuth.instance.accessToken;
        print(t?.token);
        var body = jsonEncode({
          "token": t?.token,
          "backend": "facebook",
          "grant_type": "convert_token",
          "client_id": clientId,
          "client_secret": clientSecret
        });
        var res = await http.post(
          Uri.parse("$URL/authentication/convert-token/"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );
        var decodedBody = jsonDecode(res.body);
        if (res.statusCode == 200) {
          token = decodedBody["access_token"];
          print(decodedBody);
          var response = await http.post(
            Uri.parse("$URL/auth/profile_exist/"),
            headers: {
              'Authorization': 'Bearer ${decodedBody["access_token"]}',
            },
          );
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 200) {
            saveData("AccessToken", decodedBody["access_token"]);
            saveData("RefreshToken", decodedBody["refresh_token"]);
            Get.offAllNamed('/signinstepthree');
          } else {
            Get.offAllNamed(
              '/SignUpStepOneGoogle',
              arguments: {
                "access_token": decodedBody["access_token"],
                "refresh_token": decodedBody["refresh_token"],
              },
            );
          }
        } else {
          setState(() {
            isLoading = false;
          });
          snackbar(
              context, 1, "Something reallt wrong happened", Colors.redAccent);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  String? accessTokenGoogle;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "548673393275-ukupogrdrtfbmvdkd4n2mlsekl328hc5.apps.googleusercontent.com",
    scopes: ['email'],
  );
  bool isLoading = false;

  _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signOut();
      account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account!.authentication;

      if (account != null) {
        accessTokenGoogle = authentication.accessToken;
        var body = jsonEncode({
          "token": accessTokenGoogle,
          "backend": "google-oauth2",
          "grant_type": "convert_token",
          "client_id": clientId,
          "client_secret": clientSecret
        });
        setState(() {
          isLoading = true;
        });
        var res = await http.post(
          Uri.parse("$URL/authentication/convert-token/"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );
        print(res.body);
        var decodedBody = jsonDecode(res.body);
        if (res.statusCode == 200) {
          token = decodedBody["access_token"];
          print(decodedBody);
          var response = await http.post(
            Uri.parse("$URL/auth/profile_exist/"),
            headers: {
              'Authorization': 'Bearer ${decodedBody["access_token"]}',
            },
          );
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 200) {
            saveData("AccessToken", decodedBody["access_token"]);
            saveData("RefreshToken", decodedBody["refresh_token"]);
            Get.offAllNamed('/signinstepthree');
          } else {
            Get.offAllNamed(
              '/SignUpStepOneGoogle',
              arguments: {
                "access_token": decodedBody["access_token"],
                "refresh_token": decodedBody["refresh_token"],
              },
            );
          }
        } else {
          setState(() {
            isLoading = false;
          });
          snackbar(
              context, 1, "Something reallt wrong happened", Colors.redAccent);
        }
      }
    } catch (error) {
      print(error);
    }
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
          backgroundColor: AppColor.mainColor,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Let's sign you in",
                        textStyle: GoogleFonts.montserratAlternates(
                          color: AppColor.forthColor,
                          fontSize: 23,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                          wordSpacing: 0.7,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: true,
                  ),
                ),
                const SizedBox(height: 70),
                ButtonSingnin(
                    SizeScreen.width * 0.85, SizeScreen.height * 0.065,

                    /// TODO GOOGLE SIGNIN FUNCTION
                    () {
                  _handleSignIn();
                }, AppColor.primaryColor, FontAwesomeIcons.google,
                    "Continue with Google"),
                const SizedBox(height: 30),
                ButtonSingnin(
                    SizeScreen.width * 0.85, SizeScreen.height * 0.065,
                    () async {
                  facebookLogin();
                }, AppColor.primaryColor, FontAwesomeIcons.facebook,
                    "Continue with Facebook"),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    ///TODO LATER
                    Get.toNamed("/signinscreen");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Use Email',
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: AppColor.secondaryColor),
                      ),
                      const SizedBox(width: 5),
                      const Icon(FontAwesomeIcons.angleRight,
                          color: AppColor.secondaryColor, size: 15),
                    ],
                  ),
                ),
                SizedBox(height: SizeScreen.height * 0.3),
                GestureDetector(
                  onTap: () {
                    ///TODO LATER
                    Get.toNamed("/signinstepone");
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
