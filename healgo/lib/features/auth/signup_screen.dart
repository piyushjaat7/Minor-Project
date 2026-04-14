import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passController = TextEditingController();
  final authService = AuthService();

  bool loading = false;
  String selectedRole = "patient";

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        passController.text.isEmpty) {
      showError("Please fill in all fields");
      return;
    }

    setState(() => loading = true);
    try {
      final success = await authService.signUp(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passController.text.trim(),
        role: selectedRole,
        address: addressController.text.trim(),
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully! ✅"),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        showError("Signup failed ❌");
      }
    } catch (e) {
      showError(e.toString());
    }
    if (mounted) {
      setState(() => loading = false);
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Decorative background elements
          Positioned(
            top: -50,
            left: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppColors.primary.withOpacity(0.05),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -80,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: AppColors.accent.withOpacity(0.05),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.health_and_safety,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text("Create Account", style: AppTextStyles.heading),
                  const SizedBox(height: 8),
                  Text(
                    "Join HealGo and experience seamless home healthcare.",
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 32),

                  _buildLabel("Full Name"),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your full name",
                      prefixIcon: Icon(Icons.person_outline, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Phone Number"),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Enter your phone number",
                      prefixIcon: Icon(Icons.phone_outlined, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Email Address"),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email_outlined, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Address"),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: "Enter your full address",
                      prefixIcon: Icon(Icons.location_on_outlined, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Password"),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Create a password",
                      prefixIcon: Icon(Icons.lock_outline, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Join as"),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRole,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        items: const [
                          DropdownMenuItem(value: "patient", child: Text("Patient")),
                          DropdownMenuItem(value: "provider", child: Text("Healthcare Provider")),
                        ],
                        onChanged: (value) => setState(() => selectedRole = value!),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: loading ? null : signup,
                    child: loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text("Create Account"),
                  ),

                  const SizedBox(height: 32),

                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: AppColors.textGrey, fontSize: 15),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
