import 'package:Bloc/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/create_screen/controller/controller_create_screen.dart';
import 'Screens/create_screen/create_screen.dart';
import 'Screens/details_screen/details_screen.dart';
import 'Screens/mother_screen/mother_screen.dart';
import 'Screens/see_all/see_all_screen.dart';
import 'Screens/signup_signin_screenSSS/signin_screen/singnin_screen.dart';
import 'Screens/signup_signin_screenSSS/signup_signin_screen/singnin_singnup_screen.dart';
import 'Screens/signup_signin_screenSSS/signup_steps/controller/signup_steps_controller.dart';
import 'Screens/signup_signin_screenSSS/signup_steps/signup_step_one_google.dart';
import 'Screens/signup_signin_screenSSS/signup_steps/signup_step_three.dart';
import 'Screens/signup_signin_screenSSS/signup_steps/signup_step_one.dart';
import 'Screens/signup_signin_screenSSS/signup_steps/signup_step_two.dart';
import 'Screens/splash_screen/splash_screen.dart';
import 'google.dart';

String? token;

void main() async {
  // Initialize GetX bindings
  WidgetsFlutterBinding.ensureInitialized();
  // Register your controller
  Get.put(ControllerSignUpSteps());
  Get.put(ControllerCreateScreen());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('AccessToken');
  //Get.put(ControllerCreateScreen());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: token == null ? '/' : '/signinstepthree',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/signinsignup', page: () => const SignupSingninScreen()),
        GetPage(name: '/signinstepone', page: () => const SignUpStepOne()),
        GetPage(name: '/signinsteptwo', page: () => const SignUpStepTwo()),
        GetPage(name: '/signinstepthree', page: () => const SignUpStepThree()),
        GetPage(name: '/signinscreen', page: () => const SignInScreen()),
        GetPage(name: '/motherscreen', page: () => const MotherScreen()),
        GetPage(name: '/detailsscreen', page: () => const DetailsScreen()),
        GetPage(name: '/createscreen', page: () => const CreateScreen()),
        GetPage(name: '/map', page: () => const MapSample()),
        GetPage(name: '/seeAll', page: () => const SeeAllScreen()),
        GetPage(name: '/g', page: () => SignInDemo()),
        GetPage(
            name: '/SignUpStepOneGoogle', page: () => SignUpStepOneGoogle()),
      ],
    );
  }
}
