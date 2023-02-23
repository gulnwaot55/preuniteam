import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/paddingUtil.dart';

Dialog confirmDialogUpdate({
  required String title,
  String? subTitle,
  Function? onConfirm,
  TextAlign? titleAlign,
  String? confirmText,
  String? cancelText,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ), //this right here
    child: SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
          bottom: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(2),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                textAlign: titleAlign ?? TextAlign.left,
              ),
            ),
            verticalSpace(subTitle != null ? 10 : 0),
            if (subTitle != null)
              Center(
                child: Text(
                  subTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                  ),
                  textAlign: titleAlign ?? TextAlign.center,
                ),
              ),
            verticalSpace(18),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const SizedBox(
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage('assets/images/close.png'),
                      ),
                    ),
                  ),
                  // horizontalSpace(20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('ยกเลิก'),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  horizontalSpace(70),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Text('ตกลง'),
                      onTap: () {
                        confirmText;
                        onConfirm?.call();
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      confirmText;
                      onConfirm?.call();
                    },
                    child: const SizedBox(
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/check.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
