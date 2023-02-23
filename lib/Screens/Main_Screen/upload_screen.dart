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
import 'package:netflix/Utils/paddingUtil.dart';

import '../../Services/Upload_Service/upload_feed_service.dart';
import '../Multi_Screen/navbar_screen.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  final ImagePicker imagePicker = ImagePicker();

  String imagepath = ""; //  for the path of my image
  String base64String = ""; //  data in the form of String

  String username = "";
  String uidUpload = "";
  String decs = "";

  TextEditingController decsController = TextEditingController();

  getProfile() {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference docDB =
        FirebaseFirestore.instance.collection("Users").doc(uid);
    docDB.get().then((value) {
      setState(() {
        username = value.get("username");
        uidUpload = value.get("uid");
      });
    });
  }

  openImage() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
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

        // now we can save it into database
      } else {
        print('No image is selected');
      }
    } catch (e) {
      print('Error : ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print("object");

                      openImage().then((value) {
                        setState(() {});
                      });
                    },
                    child: imagepath != ""
                        ? Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: MemoryImage(
                                        base64Decode(base64String)))),
                          )
                        : Container(
                            width: double.infinity,
                            height: 400,
                            child: Center(
                              child: Text(
                                "แตะเพื่อเลือกรูปภาพ",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                  ),
                  paddingUtilHeight(h * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: decsController,
                    ),
                  ),
                  paddingUtilHeight(h * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      onPressed: () {
                        // EasyLoading.show(status: "Uploading...");
                        decsController.text != "" || base64String != ""
                            ? UploadFeedService.uploadFeedData(
                                decsController.text,
                                username,
                                uidUpload,
                                base64String,
                                decsController,)
                            : Get.snackbar(
                                "Status", "Please complete the information",
                                colorText: Colors.white,
                                overlayBlur: 2,
                                duration: Duration(milliseconds: 1500),
                                backgroundColor: Colors.black.withOpacity(0.5),
                                icon: Icon(
                                  FontAwesomeIcons.warning,
                                  color: Colors.yellowAccent,
                                ));
                      },
                      child: Text("Upload to Feed"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showImage(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: MemoryImage(base64Decode(base64String)))),
    );
  }
}
