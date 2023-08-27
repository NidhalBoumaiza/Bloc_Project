import 'package:flutter/material.dart';

import '../constants.dart';

Widget TextFieldWidget(
  function,
  keyboardType,
  hint, {
  InputDecoration? inputdecoration,
  TextEditingController? controller,
  bool? obsecuretext,
  bool? enabled,
}) {
  return TextField(
    maxLines: 1,
    enabled: enabled ?? true,
    obscureText: obsecuretext ?? false,
    controller: controller,
    //textAlignVertical: TextAlignVertical.center,
    keyboardType: keyboardType,
    onChanged: function,
    style: const TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Color(0xffF6F6F6),
      fontSize: 15,
    ),
    textAlign: TextAlign.start,

    decoration: inputdecoration ??
        KinputDecoration.copyWith(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
  );
}
