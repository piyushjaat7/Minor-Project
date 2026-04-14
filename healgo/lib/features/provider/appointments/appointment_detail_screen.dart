import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

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
          "Appointment Details",
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: AppColors.primary, size: 32),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rahul Verma",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Patient ID: #12345",
                          style: AppTextStyles.body.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.message_outlined, color: AppColors.primary, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Text("Appointment Information", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            _buildInfoCard(
              items: [
                _InfoItem(Icons.calendar_today_outlined, "Date", "12 March 2026"),
                _InfoItem(Icons.access_time, "Time", "10:30 AM"),
                _InfoItem(Icons.medical_services_outlined, "Service", "Home Nursing"),
                _InfoItem(Icons.info_outline, "Status", "Confirmed", color: Colors.green),
              ],
            ),
            const SizedBox(height: 32),

            const Text("Patient Notes", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reason for Visit:",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Patient is experiencing persistent chest pain and needs vitals monitoring. Requires attention to blood pressure levels.",
                    style: AppTextStyles.body.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      side: const BorderSide(color: AppColors.primary),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Complete"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required List<_InfoItem> items}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: items.map((item) {
          final isLast = items.indexOf(item) == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(item.icon, size: 20, color: AppColors.textGrey),
                    const SizedBox(width: 16),
                    Text(item.label, style: AppTextStyles.body.copyWith(fontSize: 14)),
                    const Spacer(),
                    Text(
                      item.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: item.color ?? AppColors.textDark,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 24, thickness: 0.5),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  _InfoItem(this.icon, this.label, this.value, {this.color});
}
