import 'package:afyaai/models/login_model.dart';
import 'package:afyaai/models/register_model.dart';
import 'package:afyaai/utils/constants.dart';
import 'localstorage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> _storeTokens(Map<String, dynamic> data) async {
    try {
      await StorageService.storeData({
        'access_token': data['token'],
        'userName': data['user']['name'],
      });
    } catch (e) {
      print('Error storing tokens: $e');
    }
  }

  Future<Map<String, dynamic>?> login(LoginModel request) async {
    final response = await http.post(
      Uri.parse('${BASE_URL}/login'),
      headers: {
        'Content-Type': 'application/json', 'action': 'login'
      },
      body: jsonEncode({
        'action': 'login',
        'email': request.email,
        'password': request.password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await _storeTokens(data);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>?> register(RegisterModel request) async {
    final response = await http.post(
      Uri.parse('${BASE_URL}/register'),
      headers: {
        'Content-Type': 'application/json', 'action': 'login'
      },
      body: jsonEncode({
        'action': 'register',
        'name': request.name,
        'email': request.email,
        'password': request.password,
        'age': request.age,
        'gender': request.gender,
        'allergies': request.allergies,
        'existing_conditions': request.existingConditions
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<bool> logoutUser() async {
    try {
      await StorageService.removeData('access_token');
      await StorageService.removeData('userName');

      return true;
    } catch (e) {
      print('Error logging out user: $e');
      return false;
    }
  }
}