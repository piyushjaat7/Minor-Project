package com.healgo.backend.controller;

import com.healgo.backend.entity.Doctor;
import com.healgo.backend.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/doctors")   // 🔥 IMPORTANT (unique base path)
@RequiredArgsConstructor
@CrossOrigin("*")
public class DoctorController {

    private final DoctorRepository doctorRepository;

    // ✅ GET ALL DOCTORS
    @GetMapping
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    // ✅ GET DOCTOR BY ID (optional but useful)
    @GetMapping("/{id}")
    public Doctor getDoctorById(@PathVariable Long id) {
        return doctorRepository.findById(id).orElse(null);
    }
}