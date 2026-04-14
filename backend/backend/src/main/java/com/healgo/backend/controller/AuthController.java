package com.healgo.backend.controller;

import com.healgo.backend.dto.RegisterRequest;
import com.healgo.backend.entity.User;
import com.healgo.backend.repository.UserRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@CrossOrigin("*")
public class AuthController {

    private final UserRepository userRepository;

    // 🔥 SIGNUP (FIXED PROPERLY USING DTO)
    @PostMapping("/signup")
    public User signup(@Valid @RequestBody RegisterRequest request) {

        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());
        user.setRole(request.getRole());
        user.setPhone(null); // agar baad me add karega

        return userRepository.save(user);
    }

    // 🔥 LOGIN
    @PostMapping("/login")
    public User login(@RequestBody User user) {
        return userRepository
                .findByEmailAndPassword(user.getEmail(), user.getPassword());
    }

    // 🔥 GET USER PROFILE
    @GetMapping("/user/{id}")
    public User getUser(@PathVariable Long id) {
        return userRepository.findById(id).orElse(null);
    }

    // 🔥 CHANGE PASSWORD
    @PutMapping("/change-password")
    public String changePassword(@RequestBody Map<String, String> body) {

        Long userId = Long.parseLong(body.get("userId"));
        String newPassword = body.get("newPassword");

        if (newPassword == null || newPassword.length() < 6) {
            return "Password must be at least 6 characters";
        }

        User user = userRepository.findById(userId).orElse(null);

        if (user == null) {
            return "User not found";
        }

        user.setPassword(newPassword);
        userRepository.save(user);

        return "Password updated";
    }

    // 🔥 UPDATE PROFILE
    @PutMapping("/update-profile")
    public User updateProfile(@RequestBody User updatedUser) {

        User user = userRepository.findById(updatedUser.getId()).orElse(null);

        if (user == null) {
            return null;
        }

        if (updatedUser.getName() == null || updatedUser.getName().length() < 3) {
            throw new RuntimeException("Name must be at least 3 characters");
        }

        if (updatedUser.getPhone() == null || !updatedUser.getPhone().matches("^[6-9][0-9]{9}$")) {
            throw new RuntimeException("Invalid phone number");
        }

        user.setName(updatedUser.getName());
        user.setPhone(updatedUser.getPhone());

        return userRepository.save(user);
    }
}