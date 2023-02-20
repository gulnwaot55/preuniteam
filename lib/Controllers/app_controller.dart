import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Main_Screen/login_screen.dart';

class AppController {
  AppController._();
  static setLogin() async {
    final db = await SharedPreferences.getInstance();

    db.getString("token");
  }

  static setlogOut() async {
    final db = await SharedPreferences.getInstance();

    try {
      EasyLoading.show(status: "Loading...");
      db.remove("token").then((v) {
        FirebaseAuth.instance.signOut();
        Get.offAll(() => LoginScreen());
        print("Check Clear Token : ${db.getString("token")}");
      }).onError((error, stackTrace) {
        print("LogOut Error 1 : ${error.toString()}");
      });
    } catch (e) {
      print("LogOut Error 2 : ${e.toString()}");
    }
    EasyLoading.dismiss();
  }
}
