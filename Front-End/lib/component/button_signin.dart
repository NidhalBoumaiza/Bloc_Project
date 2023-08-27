import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

Widget ButtonSingnin(width, height, Function, buttonColor, icon, text) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: Function,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColor.forthColor,
            ),
            const SizedBox(width: 17),
            Text(
              text,
              style: TextStyle(
                color: AppColor.forthColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
