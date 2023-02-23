import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Services/ReadData_Service/firebase_profile_service.dart';
import 'package:netflix/Utils/message_bubbleUtil.dart';
import 'package:netflix/Utils/paddingUtil.dart';

class ReadChatsService extends StatefulWidget {
  final String docIdFeed;
  const ReadChatsService({super.key, required this.docIdFeed});

  @override
  State<ReadChatsService> createState() => _ReadChatsServiceState();
}

class _ReadChatsServiceState extends State<ReadChatsService> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CollectionReference doc = FirebaseFirestore.instance.collection("Chats");
    return FutureBuilder<DocumentSnapshot>(
      future: doc.doc(widget.docIdFeed).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return MessageBubble(
            text: data["message"],
            color: Color(0xFF1B97F3),
            tail: false,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(child: Text("ไม่พบประวัติแชท"));
        }
        return Center(child: Text("Loading..."));
      },
    );
  }
}


//data["usernameUpload"] ชุดเลือก Field ใน Doc นั้นๆ