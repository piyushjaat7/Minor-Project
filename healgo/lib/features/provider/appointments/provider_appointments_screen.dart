import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants.dart';

class ProviderAppointmentsScreen extends StatefulWidget {
  const ProviderAppointmentsScreen({super.key});

  @override
  State<ProviderAppointmentsScreen> createState() =>
      _ProviderAppointmentsScreenState();
}

class _ProviderAppointmentsScreenState
    extends State<ProviderAppointmentsScreen> {
  List appointments = [];
  bool loading = true;

  // ✅ FIXED URL
  final String baseUrl = "http://localhost:8000/api";

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final providerId = prefs.getInt("userId");

      print("PROVIDER ID: $providerId");

      final res = await http.get(
        Uri.parse("$baseUrl/provider-appointments/$providerId"),
      );

      print("APPOINTMENTS: ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        // ✅ FIX setState crash
        if (!mounted) return;

        setState(() {
          appointments = data;
          loading = false;
        });
      } else {
        if (!mounted) return;
        setState(() => loading = false);
      }
    } catch (e) {
      debugPrint("ERROR: $e");

      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  Future<void> updateStatus(int id, String status) async {
    try {
      final res = await http.put(
        Uri.parse("$baseUrl/update-status"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "status": status,
        }),
      );
      if (res.statusCode == 200) {
        fetchAppointments();
      }
    } catch (e) {
      debugPrint("Update error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppColors.textDark),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Appointments",
            style: TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textGrey,
            labelStyle:
            const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: "New"),
              Tab(text: "Confirmed"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            _buildList("searching"),
            _buildList("accepted"),
            _buildList("rejected"),
          ],
        ),
      ),
    );
  }

  Widget _buildList(String status) {
    final filtered =
    appointments.where((a) => a['status'] == status).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text("No appointments found",
            style: AppTextStyles.body),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient ID: ${item['userId']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              Text("${item['date']} at ${item['time']}"),

              if (status == "searching") ...[
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            updateStatus(item['id'], 'rejected'),
                        child: const Text("Reject"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            updateStatus(item['id'], 'accepted'),
                        child: const Text("Accept"),
                      ),
                    ),
                  ],
                )
              ]
            ],
          ),
        );
      },
    );
  }
}