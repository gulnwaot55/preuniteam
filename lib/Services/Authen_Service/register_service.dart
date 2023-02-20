import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:netflix/Screens/Main_Screen/home_screen.dart';

class RegisterService {
 
  RegisterService._();

  static register(String username, String email, String password,) {
    
    try {
      EasyLoading.show(status: "Loading...");
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password).then((value)async{
            
            String uid =  FirebaseAuth.instance.currentUser!.uid.toString();
            String time = DateTime.now().toString();
      
  
        DocumentReference users =
            FirebaseFirestore.instance.collection("Users").doc(uid);
        await users.set({
          "uid" : uid,
          "username" : username,
          "email" : email,
          "password" : password,
          "createTime" : time,
        });

        print('Update User : ${users.toString()}');
        Get.offAll(() => HomeScreen());
        EasyLoading.dismiss();
          }).onError((error, stackTrace){
            Get.snackbar(
          "Warning",
          "กรุณากรอกข้อมูลให้ถูกต้อง!",
          overlayBlur: 2,
          duration: Duration(milliseconds: 1500),
          icon: Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        print("Error Register 1 : ${error.toString()}");
        EasyLoading.dismiss();
          });
      
    } catch (e) {
      print("Error Register 2 : ${e.toString()}");
      Timer(Duration(seconds :
      3), () { 
        EasyLoading.dismiss();
      });
    }
    
  }
}



