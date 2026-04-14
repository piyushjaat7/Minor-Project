import 'package:flutter/material.dart';
import '../../core/constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
          "Notifications",
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Clear All", style: TextStyle(color: AppColors.primary)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        itemCount: 5,
        itemBuilder: (context, index) {
          final isUnread = index < 2;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
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
              border: isUnread ? Border.all(color: AppColors.primary.withOpacity(0.1), width: 1) : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUnread ? AppColors.primary.withOpacity(0.1) : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getNotificationIcon(index),
                    color: isUnread ? AppColors.primary : AppColors.textGrey,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getNotificationTitle(index),
                            style: TextStyle(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                              fontSize: 15,
                              color: AppColors.textDark,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getNotificationBody(index),
                        style: AppTextStyles.body.copyWith(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "2 hours ago",
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textGrey.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(int index) {
    List<IconData> icons = [
      Icons.celebration_outlined,
      Icons.biotech_outlined,
      Icons.local_offer_outlined,
      Icons.video_camera_front_outlined,
      Icons.person_outline,
    ];
    return icons[index % icons.length];
  }

  String _getNotificationTitle(int index) {
    List<String> titles = [
      "Welcome to HealGo!",
      "New Lab Test Available",
      "Special Discount for you",
      "Consultation Reminder",
      "Profile Updated"
    ];
    return titles[index % titles.length];
  }

  String _getNotificationBody(int index) {
    List<String> bodies = [
      "Thanks for joining HealGo. Start booking your home health care services today.",
      "Check out our new comprehensive full body checkup packages near you.",
      "Get 20% off on your first physiotherapy session. Use code HEAL20.",
      "Don't forget your scheduled video consultation at 5:00 PM today.",
      "Your profile information has been updated successfully as requested."
    ];
    return bodies[index % bodies.length];
  }
}
