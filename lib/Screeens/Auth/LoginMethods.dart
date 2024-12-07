import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spotify_clone/Screeens/Auth/Login.dart';
import 'package:spotify_clone/Screeens/Auth/sendotpScreen.dart';
import 'package:spotify_clone/Screeens/view/Dashboard.dart';

import '../../Controllers/googleauth.dart';
import '../../Utils.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                Header(),
                const SizedBox(
                  height: 130,
                ),
                BottomArea(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Header() {
    return Column(
      children: [
        const SizedBox(height: 130),
        Center(
          child: Container(
            height: screenWidth(0.2),
            width: screenWidth(0.2),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/icons2.png'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Millions of songs \n Free on Spotify.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget BottomArea() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed('/first');
          },
          child: Container(
            width: screenWidth(0.9),
            height: screenHeight(0.055),
            decoration: BoxDecoration(
              color: Colors.greenAccent[400],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Sign up for free',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Get.to(const SendOTPScreen());
          },
          child: Container(
            width: screenWidth(0.9),
            height: screenHeight(0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 13, right: 30),
                    child: Icon(
                      Icons.phone_android,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Continue with phone number',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () async {
            UserCredential? userCredential = await signInWithGoogle();
            if (userCredential != null) {
              print('Successfully signed in with Google: ${userCredential.user?.displayName}');
              Get.to(Dashboard());
            } else {
              print('Google Sign-In was canceled or failed.');
              Get.to(Dashboard());
            }
          },
          child: Container(
            width: screenWidth(0.9),
            height: screenHeight(0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 50),
                    child: Container(
                      height: 25,
                      child: Image.asset('assets/images/google3.png'),
                    ),
                  ),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () async {
            // UserCredential? userCredential = await signInWithFacebook();
            // if (userCredential != null) {
            //   print("Signed in with Facebook: ${userCredential.user?.displayName}");
            // } else {
            //   print("Facebook sign-in was unsuccessful.");
            // }
          },
          child: Container(
            width: screenWidth(0.9),
            height: screenHeight(0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Row(
                children: [
                   Padding(
                    padding: EdgeInsets.only(left: 17, right: 35),
                    child: Container(
                      height: 25,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage('assets/images/facebook.png'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to( Login());
          },
          child: const Text(
            'Log in',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
