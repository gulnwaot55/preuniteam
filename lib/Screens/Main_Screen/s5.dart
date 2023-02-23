import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Screens/Multi_Screen/header_screen.dart';
import 'package:netflix/Utils/paddingUtil.dart';
import 'package:netflix/Widgets/avatar_profile.dart';
import '../../Widgets/app_button.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  State<Screen5> createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  String username = "";
  String imageProfile = "";
  String emailUser = "";

  @override
  void initState() {
    readDataService();
    super.initState();
  }

  readDataService() {
    String uidProfile = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference docDB =
        FirebaseFirestore.instance.collection("Users").doc(uidProfile);
    docDB.get().then((dataSnapshot) {
      setState(() {
        username = dataSnapshot.get("username");
        imageProfile = dataSnapshot.get("imageProfile");
        emailUser = dataSnapshot.get("email");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 70,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              username.isNotEmpty ? headerScreen(username) : headerScreen(""),
              paddingUtilHeight(h * 0.02),
              imageProfile.isNotEmpty
                  ? avatarImageProfile(
                      context,
                      imageProfile,
                      150,
                      150,
                    )
                  : Container(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
              paddingUtilHeight(h * 0.30),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: appButtonLogOut(context, true, () {}),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
