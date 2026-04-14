import 'package:flutter/material.dart';

class ProviderNotificationsScreen extends StatelessWidget {
  const ProviderNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Mark all as read", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildNotificationItem(index);
        },
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    final notifications = [
      {
        "title": "New Appointment",
        "body": "Rahul Verma has booked a General Consultation for tomorrow at 10:30 AM.",
        "time": "2 mins ago",
        "icon": Icons.calendar_today,
        "color": Colors.blue
      },
      {
        "title": "Review Received",
        "body": "Aman Gupta gave you a 5-star rating: 'Great experience!'",
        "time": "1 hour ago",
        "icon": Icons.star,
        "color": Colors.orange
      },
      {
        "title": "Payment Received",
        "body": "₹500 has been credited to your wallet for the last consultation.",
        "time": "3 hours ago",
        "icon": Icons.account_balance_wallet,
        "color": Colors.green
      },
      {
        "title": "System Update",
        "body": "HealGo has been updated to version 2.1. Check out the new features!",
        "time": "Yesterday",
        "icon": Icons.system_update,
        "color": Colors.purple
      },
      {
        "title": "Appointment Cancelled",
        "body": "Suresh Raina has cancelled the appointment for today at 4:00 PM.",
        "time": "Yesterday",
        "icon": Icons.cancel,
        "color": Colors.red
      },
    ];

    final item = notifications[index];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (item["color"] as Color).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(item["icon"] as IconData, color: item["color"] as Color),
        ),
        title: Text(
          item["title"] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(item["body"] as String),
            const SizedBox(height: 4),
            Text(
              item["time"] as String,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
