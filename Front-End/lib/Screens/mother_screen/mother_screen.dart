import 'package:Bloc/component/snack_bar.dart';
import 'package:Bloc/component/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../component/button_next.dart';
import '../../constants.dart';
import '../create_screen/create_screen.dart';
import '../home_screen/controller/controller_home.dart';
import '../home_screen/home_screen.dart';
import '../profil_screen/profile_screen.dart';
import 'controller/controller_mother_screen.dart';

class MotherScreen extends StatefulWidget {
  const MotherScreen({Key? key}) : super(key: key);

  @override
  State<MotherScreen> createState() => _MotherScreenState();
}

class _MotherScreenState extends State<MotherScreen> {
  var controllerHome = Get.put(ControllerHome());
  String selectedValue = "Type of Events";
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
  @override
  Widget build(BuildContext context) {
    var controllermotherscreen = Get.put(ControllerMotherScreen());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: Transform(
            transform: Matrix4.translationValues(-40.0, 0.0, 0.0),
            child: Image.asset('images/littlelogo.png'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.black,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            height: SizeScreen.height * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Center(
                                  child: TextWidget(
                                      "Filter",
                                      AppColor.forthColor,
                                      18.0,
                                      FontWeight.w800,
                                      0.2),
                                ),
                                const SizedBox(height: 25),
                                TextWidget(
                                    "Distance from your location:",
                                    AppColor.forthColor,
                                    15.0,
                                    FontWeight.w600,
                                    0.1),
                                const SizedBox(height: 20),
                                SliderTheme(
                                  data: const SliderThemeData(
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius:
                                          0.0, // Set the size of the overlay
                                    ),

                                    valueIndicatorShape:
                                        PaddleSliderValueIndicatorShape(), // Set the value indicator shape
                                    showValueIndicator: ShowValueIndicator
                                        .always, // Show the value indicator
                                    trackHeight: 1.5,
                                    // rangeThumbShape: RangeSliderThumbShape(),
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 8.0,
                                      pressedElevation: 0,
                                    ),
                                    valueIndicatorTextStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.secondaryColor,
                                    ),
                                  ),
                                  child: Obx(
                                    () => Slider(
                                      label:
                                          "${controllermotherscreen.distanceValue.value.floor().toString()} Km",
                                      min: 2.0,
                                      max: 200.0,
                                      value: controllermotherscreen
                                          .distanceValue.value,
                                      onChanged: (val) {
                                        controllermotherscreen
                                            .distanceValue.value = val;
                                      },
                                      thumbColor: Colors.white,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextWidget("Event type:", AppColor.forthColor,
                                    15.0, FontWeight.w600, 0.1),
                                SizedBox(
                                  height: SizeScreen.height * 0.08,
                                  width: SizeScreen.width * 0.5,
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return DropdownButton<String>(
                                        isExpanded: true,
                                        underline: const Padding(
                                          padding: EdgeInsets.only(top: 0.0),
                                          child: Divider(
                                            color: Colors
                                                .grey, // Customize the color as needed
                                            thickness:
                                                1, // Customize the thickness as needed
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Color(0xffF6F6F6),
                                          fontSize: 15,
                                        ),
                                        value:
                                            selectedValue, // Current selected option
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: Color(0xffF6F6F6)),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                          });
                                        },
                                        dropdownColor: const Color(0xff0F0E30),
                                        items: options
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                ButtonNext(SizeScreen.width * 0.32,
                                    SizeScreen.height * 0.048, () async {
                                  if (selectedValue == "Type of Events") {
                                    snackbar(
                                        context,
                                        1,
                                        "you have to choose an event type",
                                        Colors.redAccent);
                                  } else {
                                    controllerHome.getHomeEvents(
                                        "custom&distance=${controllermotherscreen.distanceValue.value.floor()}&category=$selectedValue");
                                    Get.back();
                                  }
                                }, AppColor.secondaryColor, "Filter",
                                    circularRadious: 8.0)
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(CupertinoIcons.slider_horizontal_3))
          ],
        ),
        body: PersistentTabView(
          context,
          //controller: controllerNav.controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: AppColor.mainColor, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: AppColor.mainColor,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style8, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const HomeScreen(),
    const CreateScreen(),
    const ProfileScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      // title: ("Home"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.add),
      // title: ("create"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_outline),
      // title: ("Profile"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
