import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Screens/Multi_Screen/navbar_screen.dart';

class UploadFeedService {
  UploadFeedService._();

  static uploadFeedData(
    String decs,
    String username,
    String uid,
    String imageBase64,
    TextEditingController controller,
  ) async {
    String time = DateTime.now().toString();

    // String username = ,

    DocumentReference feed =
        FirebaseFirestore.instance.collection("UpFeed").doc();
    await feed.set({
      "uploadTime": time,
      "uidUpload": uid,
      "usernameUpload": username,
      "decs": decs,
      "imagePostBase64": imageBase64,
    }).then((value) {
      
      try {
        EasyLoading.show(status: "Uploading...");
        Timer(Duration(milliseconds: 1500), () {
          Get.snackbar("Status", "Upload Success",
              colorText: Colors.white,
              overlayBlur: 2,
              duration: Duration(milliseconds: 1500),
              backgroundColor: Colors.black.withOpacity(0.5),
              icon: Icon(
                FontAwesomeIcons.check,
                color: Colors.greenAccent,
              ));
          controller.clear();
          Get.offAll(()=> BottomNavbarScreen());
          EasyLoading.dismiss();
        });

        
      } catch (e) {
        print("Error UploadFeed Service : ${e.toString()}");
        EasyLoading.dismiss();
      }
    });
  }
}
