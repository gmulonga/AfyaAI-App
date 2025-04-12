import 'package:get/get.dart';
import 'package:afyaai/models/prompt_model.dart';
import 'package:afyaai/services/api_service.dart';

class PromptController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var diagnosisResult = {}.obs;
  var error = ''.obs;

  Future<void> getDiagnosis(String promptText) async {
    isLoading.value = true;
    error.value = '';
    diagnosisResult.clear();

    try {
      final request = PromptModel(prompt: promptText);
      final result = await _apiService.sendPrompt(request);
      if (result != null) {
        diagnosisResult.value = result;
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
