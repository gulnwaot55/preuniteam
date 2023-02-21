import 'package:flutter/material.dart';

import '../../Controllers/app_controller.dart';
import '../../Widgets/app_button.dart';

class Screen5 extends StatelessWidget {
  const Screen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70,left: 50,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              appButtonLogOut(context, true, () {
                    AppController.setlogOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
