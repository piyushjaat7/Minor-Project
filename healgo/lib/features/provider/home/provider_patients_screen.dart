import 'package:flutter/material.dart';

class ProviderPatientsScreen extends StatelessWidget {
  const ProviderPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Patients"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8, // Dummy count
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: const Icon(Icons.person, color: Colors.blue, size: 30),
              ),
              title: Text(
                "Patient Name ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text("Last Visit: 1${index} Oct 2023"),
                  Text("Condition: General Checkup", style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Patient Detail Screen if needed
              },
            ),
          );
        },
      ),
    );
  }
}
