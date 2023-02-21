import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix/Controllers/app_controller.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';
import 'package:netflix/Screens/Main_Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    //ดู Code ชุดนี้ช่วยหน่อยครับ 555
    final db = await SharedPreferences.getInstance();
    String token = db.getString("token").toString();
    AppController.setLogin();
    print("Check Get Token Splash : ${token}");
    Timer(Duration(seconds: 2), () {
      if (token.isNotEmpty) {
        Get.offAll(() => HomeScreen());
      } else if (token == null && token.isEmpty) {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        "assets/images/logo.png",
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("Loading..."),
      durationInSeconds: 2,
    );
  }
}
