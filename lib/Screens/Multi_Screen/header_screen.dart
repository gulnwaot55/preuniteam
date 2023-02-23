import 'package:flutter/material.dart';

Container headerScreen(String nameScreen,){
  return Container(
    width: double.infinity,
    height: 70,
    decoration: BoxDecoration(
      color: Colors.blueAccent
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
        Text(nameScreen,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
      ],),
    ),
  );
}