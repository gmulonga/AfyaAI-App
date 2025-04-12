import 'package:get/get.dart';
import 'package:afyaai/models/register_model.dart';
import 'package:afyaai/services/api_service.dart';
import 'package:afyaai/routes/app_routes.dart';
import 'package:afyaai/utils/constants.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var age = 0.obs;
  var gender = ''.obs;
  var allergies = <String>[].obs;
  var existingConditions = <String>[].obs;

  var isLoading = false.obs;

  final ApiService _apiService = ApiService();

  void register() async {
    if (email.value.isEmpty ||
        password.value.isEmpty ||
        name.value.isEmpty ||
        gender.value.isEmpty ||
        age.value == 0) {
      Get.snackbar("Error", "Please fill in all required fields");
      return;
    }

    isLoading.value = true;

    try {
      final registerModel = RegisterModel(
        name: name.value,
        email: email.value,
        password: password.value,
        age: age.value,
        gender: gender.value,
        allergies: allergies,
        existingConditions: existingConditions,
      );

      final result = await _apiService.register(registerModel);

      if (result != null) {
        Get.snackbar("Success", "You have created an account", colorText: kGreen);
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        "An error occurred: ${e.toString()}",
        colorText: kRed,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
