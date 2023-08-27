import 'package:Bloc/component/text_widget.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget EventComponent(
  imageLink,
  eventName,
  startTime,
  endTime,
) {
  return Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network("$URL$imageLink")),
      Positioned(
        child: Container(
          height: SizeScreen.height * 0.055,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  eventName,
                  AppColor.forthColor.withOpacity(0.7),
                  11.0,
                  FontWeight.w400,
                  0.1,
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget('test', AppColor.forthColor.withOpacity(0.7),
                        9.0, FontWeight.w300, 0.1),
                    TextWidget(
                        '11 PM - 12 PM',
                        AppColor.forthColor.withOpacity(0.7),
                        9.0,
                        FontWeight.w300,
                        0.1),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
