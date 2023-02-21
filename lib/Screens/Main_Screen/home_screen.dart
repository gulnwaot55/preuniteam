
import 'package:flutter/material.dart';

import '../../Controllers/app_controller.dart';
import '../../Widgets/app_button.dart';
import '../Multi_Screen/navbar_screen.dart';

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
        bottomNavigationBar: BottomNavbarScreen(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
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