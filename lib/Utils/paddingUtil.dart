import 'package:flutter/material.dart';

SizedBox paddingUtilHeight(double height){
  return SizedBox(
    height: height,
    width: 0,
  );
}

SizedBox paddingUtilWidth(double width){
  return SizedBox(
    height: 0,
    width: width,
  );
}

Widget verticalSpace(double? height) {
  return SizedBox(height: height ?? 0);
}

Widget horizontalSpace(double? width) {
  return SizedBox(width: width ?? 0);
}
