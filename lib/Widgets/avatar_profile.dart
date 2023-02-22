import 'dart:convert';

import 'package:flutter/material.dart';

Container avatarImageProfile(
    BuildContext context, String imageBase64, double h, double w) {
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: MemoryImage(base64Decode(imageBase64), scale: 1.0),
      ),
    ),
  );
}
