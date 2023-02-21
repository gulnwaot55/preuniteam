import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:netflix/Services/Authen_Service/register_service.dart';
import 'package:netflix/Utils/paddingUtil.dart';
import 'package:netflix/Widgets/app_button.dart';
import 'package:netflix/Widgets/app_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  String imagepath = ""; //  for the path of my image
  String base64String = ""; //  data in the form of String

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: KeyboardDismisser(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  upLoadAvatarProfile(),
                  paddingUtilHeight(height * 0.04),
                  appForm(
                    "กรุณากรอก Username",
                    Icons.person_4_rounded,
                    false,
                    _usernameController,
                  ),
                  paddingUtilHeight(height * 0.02),
                  appForm(
                    "กรุณากรอก Email",
                    Icons.email,
                    false,
                    _emailController,
                  ),
                  paddingUtilHeight(height * 0.02),
                  appForm(
                    "กรุณากรอก Password",
                    Icons.lock,
                    true,
                    _passwordController,
                  ),
                  paddingUtilHeight(height * 0.02),
                  appButtonRegister(context, true, () {
                    RegisterService.register(_usernameController.text,
                        _emailController.text, _passwordController.text);
                  }),
                  paddingUtilHeight(height * 0.01),
                  loginOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  upLoadAvatarProfile() {
    return Container(
      width: 150,
      height: 150,
      decoration: imagepath != ""
          ? BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: MemoryImage(base64Decode(base64String))))
          : BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                // print("object");
                openImage();
                // .then((value) {
                // });
              },
              icon: FaIcon(
                FontAwesomeIcons.camera,
                color: Colors.black,
              ))
        ],
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
