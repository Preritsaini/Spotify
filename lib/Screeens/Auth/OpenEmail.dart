import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/Utils.dart';

class OpenEmail extends StatelessWidget {
  const OpenEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(width: 80),
                Text(
                  'Check your email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
                child: Text(
              'We sent you an email with a link that will log you in at',
              style: TextStyle(color: Colors.white),
            )),
            SizedBox(height: 50),
            Center(
              child: Container(
                height: screenHeight(0.1),
                width: screenWidth(0.2),
                child: Image.asset('assets/images/Icon.png'),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                  child: Text('Open Email app',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
