import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentService {
  final String baseUrl = "http://10.0.2.2:8000/api"; // emulator

  // 🔥 CREATE + AUTO ASSIGN
  Future<bool> createAppointment({
    required String serviceName,
    required DateTime date,
    required String time,
  }) async {
    try {
      // 👉 फिलहाल static userId (later login add karenge)
      final userId = 1;

      // ✅ STEP 1: CREATE APPOINTMENT
      final res = await http.post(
        Uri.parse("$baseUrl/book"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "providerId": null, // initially null
          "serviceName": serviceName,
          "date": date.toIso8601String().split('T')[0],
          "time": time, // "09:00:00"
        }),
      );

      if (res.statusCode != 200) {
        print("🔥 CREATE ERROR: ${res.body}");
        return false;
      }

      print("✅ Appointment Created");

      // ❗ NOTE:
      // Agar backend me assign logic nahi likha hai,
      // to yahan se separate API call karni padegi
      // फिलहाल simple flow use kar rahe hain

      return true;
    } catch (e) {
      print("🔥 ERROR: $e");
      return false;
    }
  }

  // 🔥 OPTIONAL: GET DOCTORS
  Future<List> getDoctors() async {
    final res = await http.get(Uri.parse("$baseUrl/doctors"));
    return jsonDecode(res.body);
  }

  // 🔥 OPTIONAL: GET SLOTS
  Future<List<String>> getSlots(String doctorId, String date) async {
    final res = await http.get(
      Uri.parse("$baseUrl/slots?doctorId=$doctorId&date=$date"),
    );

    return List<String>.from(jsonDecode(res.body));
  }

  // 🔥 STATUS UPDATE (OPTIONAL – future use)
  Future<void> updateStatus(String appointmentId, String status) async {
    await http.put(
      Uri.parse("$baseUrl/appointment/status"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "appointmentId": appointmentId,
        "status": status,
      }),
    );
  }
}