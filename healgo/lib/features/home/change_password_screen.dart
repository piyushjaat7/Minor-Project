import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  Future<void> changePassword() async {

    if (newPasswordController.text != confirmPasswordController.text) {
      showMsg("Password not match ❌");
      return;
    }

    setState(() => loading = true);

    try {

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt("userId");

      final res = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/change-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "newPassword": newPasswordController.text,
        }),
      );

      if (res.statusCode == 200) {
        showMsg("Password Updated ✅");
        Navigator.pop(context);
      } else {
        showMsg("Failed ❌");
      }

    } catch (e) {
      showMsg(e.toString());
    }

    setState(() => loading = false);
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: loading ? null : changePassword,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Update Password"),
            )

          ],
        ),
      ),
    );
  }
}