import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix/Screens/Main_Screen/login_screen.dart';
import 'package:netflix/Screens/Multi_Screen/navbar_screen.dart';

import '../../Controllers/app_controller.dart';
import '../../Widgets/app_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavBarScreen(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Screen"),
            appButtonLogOut(context, true, () {
              AppController.setlogOut();
            }),
          ],
        ),
      ),
    );
  }
}



// Func Check Token // open //////////////////////////////////////
// FirebaseAuth.instance.currentUser!
//                       .getIdToken()
//                       .then((tokenID) {
//                     print("Token ID : $tokenID");
//                   });
/////////////////////////////////////////////////////////////////// close