import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/Utils/paddingUtil.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    print("object");
                  },
                  child: Container(
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
                // paddingUtilHeight(h * 0.03),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("abc"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
