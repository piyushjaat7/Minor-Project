import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://localhost:8000/api";

  // ✅ LOGIN
  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        print("Login failed: ${res.body}");
        return null;
      }
    } catch (e) {
      print("🔥 LOGIN ERROR: $e");
      return null;
    }
  }

  // ✅ SIGNUP
  Future<bool> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String address,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "role": role,
          "address": address,
        }),
      );

      return res.statusCode == 200;
    } catch (e) {
      print("🔥 SIGNUP ERROR: $e");
      return false;
    }
  }

  // ✅ GET USER PROFILE
  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/user/$userId"),
      );

      return jsonDecode(res.body);
    } catch (e) {
      print("🔥 PROFILE ERROR: $e");

      return {
        'role': 'patient',
        'name': 'User',
        'address': ''
      };
    }
  }
}