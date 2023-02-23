import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Screens/Multi_Screen/header_screen.dart';

import '../../Services/ReadData_Service/read_feeds_service.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {


  List<String> docFeed = [];

  Future getDocFeed() async {
    await FirebaseFirestore.instance
        .collection("UpFeed")
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              print(doc.reference.id);
              docFeed.add(doc.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            headerScreen("Unicorn Team Feeds"),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: FutureBuilder(
                future: getDocFeed(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docFeed.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          tileColor: Colors.grey.withOpacity(0.1),
                          title: ReadFeedsService(docIdFeed: docFeed[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
