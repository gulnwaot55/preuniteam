import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix/Screens/Main_Screen/login_screen.dart';
import 'package:netflix/Screens/Main_Screen/register_screen.dart';

TextField appForm(
  String text,
  IconData icon,
  bool isPasswordType,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(
      color: Colors.black.withOpacity(0.9),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black54,
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.9),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Row registerOption() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "ยังไม่ได้สมัครใช่มั้ย ? ",
        style: TextStyle(color: Colors.blueGrey),
      ),
      GestureDetector(
        onTap: () {
          Get.to(() => const RegisterScreen());
        },
        child: const Text(
          "สมัครเลยสิ !",
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Row loginOption() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "เคยสมัครแล้วสินะ ? ",
        style: TextStyle(color: Colors.blueGrey),
      ),
      GestureDetector(
        onTap: () {
          Get.offAll(() => const LoginScreen());
        },
        child: const Text(
          "กลับไป !",
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
