import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString("name") ?? "";
      // Phone might not be in prefs, would usually fetch from API, but for now:
      phoneController.text = ""; 
    });
  }

  Future<void> updateProfile() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      showMsg("Please fill all fields");
      return;
    }

    setState(() => loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt("userId");

      final res = await http.put(
        Uri.parse("http://localhost:8000/api/update-profile"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": userId,
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
        }),
      );

      if (res.statusCode == 200) {
        await prefs.setString("name", nameController.text.trim());
        showMsg("Profile Updated ✅");
        if (mounted) Navigator.pop(context);
      } else {
        showMsg("Update failed ❌");
      }
    } catch (e) {
      showMsg("An error occurred");
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.person, size: 60, color: AppColors.primary),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_outlined, size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            _buildLabel("Full Name"),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter your name",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            
            const SizedBox(height: 24),
            
            _buildLabel("Phone Number"),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Enter your phone number",
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            
            const SizedBox(height: 48),
            
            ElevatedButton(
              onPressed: loading ? null : updateProfile,
              child: loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark),
      ),
    );
  }
}
