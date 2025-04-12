import 'package:get/get.dart';
import 'package:afyaai/models/login_model.dart';
import 'package:afyaai/services/api_service.dart';
import 'package:afyaai/routes/app_routes.dart';
import 'package:afyaai/utils/constants.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Email and password are required");
      return;
    }

    isLoading.value = true;

    try {
      final loginModel = LoginModel(email: email.value, password: password.value);
      final result = await _apiService.login(loginModel);

      if (result != null) {
        Get.snackbar("Success", "Welcome ${result['user']['name']}",colorText: kGreen,);
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        "Please check your credentials",
        colorText: kRed,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
