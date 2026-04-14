package com.healgo.backend.service;

import com.healgo.backend.dto.RegisterRequest;
import com.healgo.backend.entity.Doctor;
import com.healgo.backend.entity.User;
import com.healgo.backend.repository.DoctorRepository;
import com.healgo.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    public User registerUser(RegisterRequest request) {

        // ✅ 1. Save user
        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());
        user.setRole(request.getRole());

        User savedUser = userRepository.save(user);

        System.out.println("✅ User Saved ID: " + savedUser.getId());

        // ❗ SAFETY CHECK (IMPORTANT)
        if (savedUser.getId() == null) {
            throw new RuntimeException("User not saved properly!");
        }

        // ✅ 2. Agar provider hai → doctors table me save
        if ("provider".equalsIgnoreCase(request.getRole())) {

            System.out.println("🔥 Provider detected, creating doctor...");

            Doctor doctor = new Doctor();

            // ✅ IMPORTANT FIX (force set)
            doctor.setUser(savedUser);

            doctor.setExperience(
                    request.getExperience() != null ? request.getExperience() : 0
            );

            doctor.setSpecialization(
                    request.getSpecialization() != null ? request.getSpecialization() : "Not Specified"
            );

            Doctor savedDoctor = doctorRepository.save(doctor);

            System.out.println("✅ Doctor Saved with user_id: " + savedUser.getId());
        }

        return savedUser;
    }
}