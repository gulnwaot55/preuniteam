import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';
import 'package:netflix/Utils/paddingUtil.dart';
import 'package:netflix/Widgets/app_button.dart';
import 'package:netflix/Widgets/app_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: KeyboardDismisser(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  paddingUtilHeight(height * 0.01),
                  appForm(
                    "กรุณากรอก Email",
                    Icons.email,
                    false,
                    _emailController,
                  ),
                  paddingUtilHeight(height * 0.02),
                  appForm(
                    "กรุณากรอก Password",
                    Icons.lock,
                    true,
                    _passwordController,
                  ),
                  paddingUtilHeight(height * 0.03),
                  appButtonLogin(context, true, () {
                    
                    try {
                      EasyLoading.show(status: "Loading...");
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) {
                        Get.offAll(() => const HomeScreen());
                        print("Login Success");
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
                  }),
                  paddingUtilHeight(height * 0.02),
                  registerOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
