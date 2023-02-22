import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Services/ReadData_Service/firebase_profile_service.dart';
import 'package:netflix/Widgets/avatar_profile.dart';

import '../../Controllers/app_controller.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70, left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                imageProfile.isNotEmpty
                    ? Expanded(
                        child: avatarImageProfile(
                          context,
                          imageProfile,
                          150,
                          150,
                        ),
                      )
                    : Container(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      ),
                username.isNotEmpty ? Text(username) : Text("ไม่พบ Username"),
                emailUser.isNotEmpty ? Text(emailUser) : Text("ไม่พบ Email"),
                appButtonLogOut(context, true, () {
                  AppController.setlogOut();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
