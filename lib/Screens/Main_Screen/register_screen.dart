import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:netflix/Screens/Main_Screen/login_screen.dart';
import 'package:netflix/Services/Authen_Service/register_service.dart';
import 'package:netflix/Utils/paddingUtil.dart';
import 'package:netflix/Widgets/app_button.dart';
import 'package:netflix/Widgets/app_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
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
                top: 80,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  paddingUtilHeight(height * 0.01),
                  appForm(
                    "กรุณากรอก Username",
                    Icons.person_4_rounded,
                    false,
                    _usernameController,
                  ),
                  paddingUtilHeight(height * 0.02),
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
                  paddingUtilHeight(height * 0.02),
                  appButtonRegister(context, true, () {
                    RegisterService.register(_usernameController.text,
                        _emailController.text, _passwordController.text);
                  }),
                  paddingUtilHeight(height * 0.01),
                  loginOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
