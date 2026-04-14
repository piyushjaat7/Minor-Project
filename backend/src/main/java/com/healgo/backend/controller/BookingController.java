package com.healgo.backend.controller;

import com.healgo.backend.entity.Appointment;
import com.healgo.backend.repository.AppointmentRepository;
import com.healgo.backend.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@CrossOrigin("*")
public class BookingController {

    private final DoctorRepository doctorRepo;
    private final AppointmentRepository appointmentRepo;

    // 🔥 GET AVAILABLE SLOTS
    @GetMapping("/slots")
    public List<String> getSlots(
            @RequestParam Long doctorId,
            @RequestParam String date
    ) {
        LocalDate d = LocalDate.parse(date);

        List<Appointment> booked =
                appointmentRepo.findByProviderIdAndDate(doctorId, d);

        List<String> bookedSlots = booked.stream()
                .map(a -> a.getTime().toString().substring(0, 5))
                .toList();

        List<String> allSlots = List.of(
                "09:00", "10:00", "11:00",
                "12:00", "14:00", "15:00"
        );

        return allSlots.stream()
                .filter(s -> !bookedSlots.contains(s))
                .toList();
    }

    // 🔥 BOOK APPOINTMENT (FINAL FIX)
    @PostMapping("/book")
    public String book(@RequestBody Appointment a) {

        // ✅ DEFAULT STATUS SET
        a.setStatus("searching");

        // ✅ SAFETY (agar null aaye toh)
        if (a.getProviderId() == null) {
            a.setProviderId(1L); // fallback (optional)
        }

        appointmentRepo.save(a);
        return "Booked Successfully";
    }

    // 🔥 GET PROVIDER APPOINTMENTS
    @GetMapping("/provider-appointments/{providerId}")
    public List<Appointment> getProviderAppointments(@PathVariable Long providerId) {
        return appointmentRepo.findByProviderId(providerId);
    }

    // 🔥 UPDATE STATUS
    @PutMapping("/update-status")
    public String updateStatus(@RequestBody Appointment a) {
        Appointment appt = appointmentRepo.findById(a.getId()).orElse(null);

        if (appt == null) return "Not found";

        appt.setStatus(a.getStatus()); // accepted / rejected
        appointmentRepo.save(appt);

        return "Updated";
    }
}