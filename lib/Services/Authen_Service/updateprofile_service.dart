import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileService {
  UpdateProfileService._();

  static register(
    String imageProfile,
  ) async {
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        DocumentReference users =
            FirebaseFirestore.instance.collection("Users").doc(uid);
        await users.update({
          "imageProfile": imageProfile,
        });

        print('Update User : ${users.toString()}');
        EasyLoading.dismiss();
  }
}
