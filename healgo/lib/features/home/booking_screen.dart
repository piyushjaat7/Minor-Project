import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;

  const BookingScreen({
    super.key,
    required this.serviceName,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  DateTime? selectedDate;
  String? selectedTimeSlot;

  List doctors = [];
  String? selectedDoctorId;
  List<String> availableSlots = [];
  bool isBooking = false;
  bool isLoadingDoctors = true;

  final String baseUrl = "http://localhost:8000/api";

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  // ✅ FETCH DOCTORS
  Future<void> fetchDoctors() async {
    setState(() => isLoadingDoctors = true);

    try {
      final res = await http.get(Uri.parse("$baseUrl/doctors"));

      print("DOCTORS: ${res.body}");

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        List doctorList = [];

        if (decoded is List) {
          doctorList = decoded;
        } else if (decoded is Map && decoded['data'] != null) {
          doctorList = decoded['data'];
        }

        setState(() {
          doctors = doctorList;
          isLoadingDoctors = false;
        });
      } else {
        setState(() => isLoadingDoctors = false);
      }
    } catch (e) {
      print("ERROR: $e");
      setState(() => isLoadingDoctors = false);
    }
  }

  // ✅ FETCH SLOTS
  Future<void> fetchSlots() async {
    if (selectedDate == null || selectedDoctorId == null) return;

    final date = selectedDate!.toIso8601String().split('T')[0];

    try {
      final res = await http.get(
        Uri.parse("$baseUrl/slots?doctorId=$selectedDoctorId&date=$date"),
      );

      print("SLOTS: ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        setState(() {
          availableSlots = List<String>.from(data);
        });
      }
    } catch (e) {
      showMsg("Failed to fetch slots");
    }
  }

  // ✅ BOOKING
  Future<void> handleBooking() async {
    if (isBooking) return;

    if (selectedDoctorId == null) {
      showMsg("Please select a doctor");
      return;
    }

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      showMsg("Please fill all details");
      return;
    }

    if (selectedDate == null || selectedTimeSlot == null) {
      showMsg("Please select date & time slot");
      return;
    }

    setState(() => isBooking = true);

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/book"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": 1,
          "providerId": int.parse(selectedDoctorId!),
          "serviceName": widget.serviceName,
          "date": selectedDate!.toIso8601String().split('T')[0],
          "time": "$selectedTimeSlot:00"
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        showMsg("Booked Successfully ✅");
        Navigator.pop(context);
      } else {
        showMsg("Booking failed ❌");
      }
    } catch (e) {
      showMsg("Booking failed ❌");
    } finally {
      if (mounted) setState(() => isBooking = false);
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Book ${widget.serviceName}",
          style: const TextStyle(
              color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Doctor", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),

            isLoadingDoctors
                ? const Center(child: CircularProgressIndicator())
                : doctors.isEmpty
                ? const Text("No doctors available")
                : SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doc = doctors[index];
                  final isSelected =
                      selectedDoctorId == doc['id'].toString();

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        selectedDoctorId =
                            doc['id'].toString();
                        selectedTimeSlot = null;
                      });
                      await fetchSlots();
                    },
                    child: Container(
                      width: 140,
                      margin:
                      const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: isSelected
                                ? Colors.white24
                                : AppColors.secondary,
                            child: Icon(Icons.person,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primary),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Dr ${doc['user']?['name'] ?? 'Unknown'}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textDark,
                            ),
                          ),
                          Text(
                            doc['specialization'] ?? "General",
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textGrey,
                            ),
                          ),
                          Text(
                            "${doc['experience'] ?? 0} yrs",
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            const Text("Patient Details",
                style: AppTextStyles.subHeading),

            const SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Patient Name",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Full Address",
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            const SizedBox(height: 32),

            const Text("Schedule", style: AppTextStyles.subHeading),
            const SizedBox(height: 16),

            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate:
                  DateTime.now().add(const Duration(days: 30)),
                  initialDate: DateTime.now(),
                );

                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                    selectedTimeSlot = null;
                  });
                  await fetchSlots();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate == null
                          ? "Select Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 TIME SLOTS UI
            if (availableSlots.isNotEmpty) ...[
              const Text("Select Time Slot",
                  style: AppTextStyles.subHeading),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: availableSlots.map((slot) {
                  final isSelected = selectedTimeSlot == slot;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = slot;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                        Border.all(color: AppColors.primary),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textDark,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isBooking ? null : handleBooking,
              child: const Text("Confirm Appointment"),
            ),
          ],
        ),
      ),
    );
  }
}