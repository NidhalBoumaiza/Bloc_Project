import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

Widget ButtonNext(width, height, function, buttonColor, text,
    {double? circularRadious}) {
  return SizedBox(
    width: width,
    height: height,
    child: AbsorbPointer(
      absorbing: false,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: buttonColor,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadious ?? 15),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColor.forthColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
