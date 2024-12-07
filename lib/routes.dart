import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:spotify_clone/Screeens/Auth/LoginMethods.dart';
import 'package:spotify_clone/Screeens/Auth/Signup.dart';
import 'package:spotify_clone/Screeens/Auth/confirmpassword.dart';
import 'package:spotify_clone/Screeens/Auth/createpassword.dart';
import 'Screeens/Splash.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: '/', page: ()=> LoginMethods()),
    GetPage(name: '/splash', page: ()=> SplashScreen()),
    GetPage(name: '/first', page: () => SignupScreen()),
    GetPage(name: '/second', page: () => CreatePasswordScreen()),
    GetPage(name: '/third', page: () => ConfirmPasswordScreen()),
    // GetPage(name: '/Signup', page: () => SignUpScreen()),
    //

  ];
}