// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

TextStyle appbarCustTextStyle(
    Color color, FontWeight fontWeight, double fontSize) {
  return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
}

TextStyle appbarTextStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle kButtonTextStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
}

TextStyle kButtonSmallTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}

//SizedboxConstant

SizedBox sizedBox10() {
  return SizedBox(height: 10);
}

SizedBox sizedBox15() {
  return SizedBox(height: 10);
}

SizedBox sizedBox20() {
  return SizedBox(height: 10);
}

SizedBox customSizeHeight(
  double height,
) {
  return SizedBox(height: height);
}
