import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProfileService {
  FirebaseProfileService._();
  //Func Read Data Firebase
  static profileService() {
    String uidProfile = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference docDB =
        FirebaseFirestore.instance.collection("Users").doc(uidProfile);
    docDB.get().then((value) {
      print(value.get("username"));
    });
  }
}
