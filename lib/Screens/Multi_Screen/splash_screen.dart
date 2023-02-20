
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';
import 'package:netflix/Screens/Main_Screen/login_screen.dart';

import '../../Services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(logo: Image.asset("assets/images/logo.png",),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("Loading..."),
      durationInSeconds: 2,
      navigator: LoginScreen()
    );
  }
}