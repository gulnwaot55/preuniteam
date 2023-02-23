
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:netflix/Screens/Multi_Screen/header_screen.dart';
import 'package:netflix/Services/ReadData_Service/read_chats_service.dart';
import 'package:netflix/Utils/paddingUtil.dart';

import '../../Utils/message_barUtil.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  void initState() {
    getDocChats();
    super.initState();
  }

  List<String> chatList = [];

  Future getDocChats() async {
    await FirebaseFirestore.instance
        .collection("Chats")
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              print(doc.reference.id);
              chatList.add(doc.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: KeyboardDismisser(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerScreen("Group Chats"),
            paddingUtilHeight(h * 0.01),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.2),
                  onRefresh: getDocChats,
                  child: FutureBuilder(
                    future: getDocChats(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: ListTile(
                              title:
                                  ReadChatsService(docIdFeed: chatList[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: bottomForm(),
            ),
          ],
        ),
      ),
    ));
  }
  bottomForm() {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    String time = DateTime.now().toString();

    return MessageBarUtil(
      onSend: (message) async {
        DocumentReference messageChats =
            FirebaseFirestore.instance.collection("Chats").doc();
        await messageChats.set({
          "uid": uid,
          "message": message,
          "senderTime": time,
        });
        setState(() {
        });
      },
    );
  }
}
