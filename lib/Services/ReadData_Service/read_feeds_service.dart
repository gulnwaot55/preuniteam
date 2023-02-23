import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Services/ReadData_Service/firebase_profile_service.dart';
import 'package:netflix/Utils/paddingUtil.dart';

class ReadFeedsService extends StatefulWidget {
  final String docIdFeed;
  const ReadFeedsService({super.key, required this.docIdFeed});

  @override
  State<ReadFeedsService> createState() => _ReadFeedsServiceState();
  
}

class _ReadFeedsServiceState extends State<ReadFeedsService> {

  String uidUpload = "";

  @override
  void initState() {
    // profileService();
    super.initState();
  }

  profileService() async {
    DocumentReference docDB =
        FirebaseFirestore.instance.collection("Users").doc(uidUpload);
    docDB.get().then((value) {
      print(value.get("username"));
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CollectionReference doc = FirebaseFirestore.instance.collection("UpFeed");
    return FutureBuilder<DocumentSnapshot>(
      future: doc.doc(widget.docIdFeed).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            width: double.infinity,
            child: Column(children: [
              paddingUtilHeight(h * 0.01),
              Row(
                children: [
                  uidUpload != "" ?  CircleAvatar(backgroundImage: MemoryImage(base64Decode("")),) : CircleAvatar(),
                  paddingUtilWidth(w * 0.02),
                  Text(data["usernameUpload"]),
                ],
              ),
              paddingUtilHeight(h * 0.01),
              Image.memory(base64Decode(data["imagePostBase64"])),
              paddingUtilHeight(h * 0.01),
              Row(
                children: [
                  Text(data["uploadTime"]),
                ],
              ),
              paddingUtilHeight(h * 0.01),
              Row(
                children: [
                  Expanded(child: Text(data["decs"])),
                ],
              ),
              paddingUtilHeight(h * 0.05),
            ],),
          );
        }
        return Center(child: Text("Loading..."));
      },
      
    );
  }
}


//data["usernameUpload"] ชุดเลือก Field ใน Doc นั้นๆ