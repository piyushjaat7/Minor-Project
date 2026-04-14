import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'service_detail_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
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
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full Health Checkup",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Up to 50% off on all home lab tests this week.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.local_hospital,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
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
            const Text("Welcome to HealGo", style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            const SizedBox(height: 32),
            const Text(
              "Our Services",
              style: AppTextStyles.subHeading,
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: [
                _buildServiceCard(context, "Nurses", Icons.medical_services_outlined, () {
                  _navigateToDetail(context, "Home Nursing Service", "Professional nurses available at home for post-surgery care, injections, vitals monitoring and patient support.", Icons.medical_services_outlined, ["Post Surgery Care", "Injection & IV Support", "Vitals Monitoring"]);
                }),
                _buildServiceCard(context, "Care Taker", Icons.elderly_outlined, () {
                  _navigateToDetail(context, "Patient Care Taker", "Trained care takers for daily patient support including hygiene care, mobility help and feeding assistance.", Icons.elderly_outlined, ["Daily Hygiene Support", "Mobility Assistance", "Feeding Support"]);
                }),
                _buildServiceCard(context, "Physiotherapy", Icons.fitness_center_outlined, () {
                  _navigateToDetail(context, "Home Physiotherapy", "Certified physiotherapists for injury recovery, pain management and mobility improvement sessions at home.", Icons.fitness_center_outlined, ["Pain Relief Therapy", "Injury Recovery Plans", "Home Visit Sessions"]);
                }),
                _buildServiceCard(context, "Lab Tests", Icons.biotech_outlined, () {
                  _navigateToDetail(context, "Home Lab Test Service", "Book blood tests and diagnostics with home sample collection and fast digital reports.", Icons.biotech_outlined, ["Home Sample Collection", "Fast Digital Reports", "Certified Labs"]);
                }),
                _buildServiceCard(context, "Doctor Consult", Icons.video_camera_front_outlined, () {
                  _navigateToDetail(context, "Doctor Video Consultation", "Consult certified doctors online via video call for quick medical advice and prescriptions.", Icons.video_camera_front_outlined, ["Online Video Consultation", "Digital Prescription", "Quick Medical Advice"]);
                }),
                _buildServiceCard(context, "Newborn Care", Icons.child_care_outlined, () {
                  _navigateToDetail(context, "Newborn Baby Care", "Professional newborn baby care including hygiene care, feeding support and sleep monitoring.", Icons.child_care_outlined, ["Baby Hygiene Care", "Feeding Support", "Sleep Monitoring"]);
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textGrey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.biotech_outlined), activeIcon: Icon(Icons.biotech), label: "Lab"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: "Care"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: "Orders"),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String title, String desc, IconData icon, List<String> benefits) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetailScreen(
          title: title,
          description: desc,
          icon: icon,
          benefits: benefits,
        ),
      ),
    );
  }
}
