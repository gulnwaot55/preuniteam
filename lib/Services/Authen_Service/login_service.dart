import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/Main_Screen/home_screen.dart';

class LoginService {
  LoginService._();

  static loginController(String email, String password) async {
    final db = await SharedPreferences.getInstance();
    try {
      EasyLoading.show(status: "Loading...");
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(() => const HomeScreen());
        print("Login Success");
        FirebaseAuth.instance.currentUser!.getIdToken().then((tokenID) {
          print("Token ID : $tokenID");
          db.setString("token", tokenID);
          print("Test Get Token Local Data : ${db.getString("token")} ");
        });
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
        print("Error Login 1 : ${error.toString()}");
        EasyLoading.dismiss();
      });
    } catch (e) {
      print("Error Login 2 : ${e.toString()}");
      EasyLoading.dismiss();
    }
  }
}
