import 'package:get/get.dart';

class PasswordController extends GetxController {
  // Observable variable to toggle password visibility
  var isPasswordVisible = false.obs;

  // Method to toggle the password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
