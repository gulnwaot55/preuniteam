import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';
import 'package:netflix/Services/Authen_Service/converse_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  RegisterService._();

  static register(
    String username,
    String email,
    String password,
  ) async {
    final db = await SharedPreferences.getInstance();
    try {
      EasyLoading.show(status: "Loading...");
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        String time = DateTime.now().toString();

        FirebaseAuth.instance.currentUser!.getIdToken().then((tokenID) {
          print("Token ID : $tokenID");
          db.setString("token", tokenID);
          print("Test Get Token Local Data : ${db.getString("token")} ");
        });

        DocumentReference users =
            FirebaseFirestore.instance.collection("Users").doc(uid);
        await users.set({
          "uid": uid,
          "username": username,
          "email": email,
          "password": password,
          "createTime": time,
        });

        print('Update User : ${users.toString()}');
        Get.offAll(() => HomeScreen());
        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Warning",
          "กรุณากรอกข้อมูลให้ถูกต้อง!",
          overlayBlur: 2,
          duration: Duration(milliseconds: 1500),
          icon: Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        print("Error Register 1 : ${error.toString()}");
        EasyLoading.dismiss();
      });
    } catch (e) {
      print("Error Register 2 : ${e.toString()}");
      Timer(Duration(seconds: 3), () {
        EasyLoading.dismiss();
      });
    }
  }
}
