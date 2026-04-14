import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import '../profile/provider_profile_screen.dart';
import '../appointments/provider_appointments_screen.dart';
import '../services/my_services_screen.dart';
import '../home/provider_patients_screen.dart';
import '../home/provider_reviews_screen.dart';
import '../home/provider_notifications_screen.dart';

class ProviderHomeScreen extends StatefulWidget {
  final String providerName;

  const ProviderHomeScreen({
    super.key,
    required this.providerName,
  });

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.health_and_safety,
              color: AppColors.primary,
              size: 32,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,", style: AppTextStyles.body.copyWith(fontSize: 14)),
            Text(
              widget.providerName,
              style: const TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications_none, color: AppColors.textDark, size: 20),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderNotificationsScreen())),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person_outline, color: AppColors.textDark, size: 20),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderProfileScreen())),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Availability Status Card
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (isOnline ? Colors.green : Colors.grey).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isOnline ? Icons.check_circle_outline : Icons.pause_circle_outline,
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isOnline ? "You are Online" : "You are Offline",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          isOnline ? "Patients can book your services" : "Bookings are temporarily disabled",
                          style: AppTextStyles.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isOnline,
                    onChanged: (val) => setState(() => isOnline = val),
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Statistics Grid
            Row(
              children: [
                _buildStatCard("Total Earnings", "₹2,450", Icons.account_balance_wallet_outlined, AppColors.primary),
                const SizedBox(width: 20),
                _buildStatCard("Total Patients", "128", Icons.people_outline, Colors.orange),
              ],
            ),
            const SizedBox(height: 32),

            // Upcoming Appointments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Upcoming Appointments", style: AppTextStyles.subHeading),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderAppointmentsScreen())),
                  child: const Text("See All", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildUpcomingAppointment("John Doe", "10:30 AM", "General Consultation"),
            _buildUpcomingAppointment("Jane Smith", "02:00 PM", "Follow-up"),
            
            const SizedBox(height: 32),

            // Quick Actions
            const Text("Quick Actions", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
              children: [
                _buildActionCard("Appointments", Icons.calendar_month_outlined, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderAppointmentsScreen()));
                }),
                _buildActionCard("My Patients", Icons.groups_outlined, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderPatientsScreen()));
                }),
                _buildActionCard("Services", Icons.medical_services_outlined, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyServicesScreen()));
                }),
                _buildActionCard("Reviews", Icons.star_outline, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderReviewsScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.body.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointment(String name, String time, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.person, color: AppColors.primary),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
        subtitle: Text("$type • $time", style: AppTextStyles.body.copyWith(fontSize: 12)),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.chevron_right, size: 20, color: AppColors.primary),
        ),
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProviderAppointmentsScreen()),
          );
        },
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}
