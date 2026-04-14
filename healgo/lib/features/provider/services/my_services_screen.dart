import 'package:flutter/material.dart';
import 'add_service_screen.dart';
import 'edit_service_screen.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  // Move list to state so it can be updated
  List<Map<String, String>> services = [
    {"name": "General Consultation", "price": "₹500", "duration": "30 mins", "description": "Initial checkup and general health advice."},
    {"name": "Cardiology Checkup", "price": "₹1200", "duration": "45 mins", "description": "Comprehensive heart health evaluation."},
    {"name": "Follow-up Visit", "price": "₹300", "duration": "15 mins", "description": "Quick review of previous consultation."},
  ];

  void _updateService(int index, Map<String, String> updatedService) {
    setState(() {
      services[index] = updatedService;
    });
  }

  void _deleteService(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Services"),
      ),
      body: services.isEmpty 
        ? const Center(child: Text("No services added yet."))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildServiceCard(context, index);
            },
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddServiceScreen()),
          );
        },
        label: const Text("Add Service"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, int index) {
    final service = services[index];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.medical_services_outlined, color: Colors.blue),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${service["duration"]} • ${service["price"]}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: Colors.green,
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditServiceScreen(
                          service: service,
                          onUpdate: (updatedData) => _updateService(index, updatedData),
                          onDelete: () => _deleteService(index),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text("Edit"),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    _showDeleteDialog(context, index);
                  },
                  icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                  label: const Text("Delete", style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Service"),
        content: const Text("Are you sure you want to delete this service?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteService(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Service deleted successfully")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
