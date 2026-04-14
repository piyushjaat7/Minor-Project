import 'package:flutter/material.dart';
import '../../core/constants.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          "Help & Support",
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How can we help you today?",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Our team is here to support your healthcare needs.",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.support_agent, size: 48, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text("Contact Information", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            _buildContactCard(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@healgo.com",
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.phone_outlined,
              title: "Phone Support",
              subtitle: "+91 98765 43210",
              onTap: () {},
            ),
            _buildContactCard(
              icon: Icons.access_time,
              title: "Support Hours",
              subtitle: "9 AM - 6 PM (Mon - Sat)",
              onTap: null,
            ),
            const SizedBox(height: 32),
            const Text("Frequently Asked Questions", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            _buildFaqItem("How do I book a service?", "You can book any service directly from the home screen by selecting the service and choosing an available slot."),
            _buildFaqItem("Can I cancel my appointment?", "Yes, you can cancel your appointment from the 'Orders' or 'Appointments' section before the scheduled time."),
            _buildFaqItem("How do I pay for the services?", "We currently support cash on delivery and are working on adding digital payment methods soon."),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: AppTextStyles.body.copyWith(fontSize: 13)),
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textGrey) : null,
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(answer, style: AppTextStyles.body.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
