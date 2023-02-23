import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netflix/Screens/Multi_Screen/header_screen.dart';
import 'package:netflix/Services/Authen_Service/updateprofile_service.dart';
import 'package:netflix/Utils/paddingUtil.dart';
import 'package:netflix/Widgets/avatar_profile.dart';
import '../../Widgets/app_button.dart';
import '../Multi_Screen/navbar_screen.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  String username = "";
  String imageProfile = "";
  String emailUser = "";
  String imagepath = ""; //  for the path of my image
  String base64String = ""; //  data in the form of String

  @override
  void initState() {
    readDataService();
    super.initState();
  }

  final ImagePicker imagePicker = ImagePicker();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      openImage();
                    },
                    child: Text("เปลี่ยนรูปโปรไฟล์"),
                  ),
                ],
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

  openImage() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        EasyLoading.show(status: "Uploading...");
        imagepath = pickedFile.path;
        print(
            imagepath); // /data/user/0/com.example.imagedecoding/cache/image_picker4858479242096916017.png

        // now convert it into a file and then numbers or bytes
        File imagefile = File(imagepath);
        // now converting into numbers

        Uint8List imagebytes = await imagefile.readAsBytes();
        print(imagebytes); // 38439849384

        // now convert it into string
        base64String =
            base64.encode(imagebytes); // asdfjaklsdfjl//asdfasd348309
        print(base64String);

        Timer(Duration(milliseconds: 2000), () {
          UpdateProfileService.register(base64String).then((value) {
            setState(() {
              Get.snackbar("Status", "Update Profile Success",
                  overlayBlur: 2,
                  colorText: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.8),
                  duration: Duration(milliseconds: 2000),
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.greenAccent,
                  ));
              Get.offAll(() => BottomNavbarScreen());
              EasyLoading.dismiss();
            });
          });
        });
        // now we can save it into database
      } else {
        print('No image is selected');
        EasyLoading.dismiss();
      }
    } catch (e) {
      print('Error : ${e}');
      EasyLoading.dismiss();
    }
  }
}
