import 'package:Bloc/component/text_widget.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget DateTimeWidget(date, time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget("Date:", Color(0xff5C596D), 17.0, FontWeight.w700, 0.2),
          SizedBox(
            height: 15,
          ),
          TextWidget(
            date,
            AppColor.forthColor,
            12.00,
            FontWeight.w500,
            0.0,
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget("Time:", Color(0xff5C596D), 17.0, FontWeight.w700, 0.2),
          SizedBox(
            height: 15,
          ),
          TextWidget(
            time,
            AppColor.forthColor,
            12.00,
            FontWeight.w500,
            0.0,
          ),
        ],
      )
    ],
  );
}
