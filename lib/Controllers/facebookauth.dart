// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// Future<UserCredential?> signInWithFacebook() async {
//   try {
//     // Trigger the Facebook sign-in flow
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//
//     // Check if login was successful
//     if (loginResult.status == LoginStatus.success && loginResult.accessToken != null) {
//       // Create a credential from the access token
//       final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//       // Sign in to Firebase with the Facebook credential
//       return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     } else {
//       print("Facebook sign-in failed: ${loginResult.message}");
//       return null;
//     }
//   } catch (e) {
//     print("Error during Facebook sign-in: $e");
//     return null;
//   }
// }
