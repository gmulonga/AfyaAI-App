import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void login() {
    print('Logging in with $email and $password');
  }
}
