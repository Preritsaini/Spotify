import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/Utils.dart';

import '../Controllers/SplashController.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());
   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: screenHeight(0.5),
          width: screenWidth(0.5),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/Icon.png'))),
        ),
      ),
    );
  }
}
