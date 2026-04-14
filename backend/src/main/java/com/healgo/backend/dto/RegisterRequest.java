package com.healgo.backend.dto;

import jakarta.validation.constraints.*;

public class RegisterRequest {

    @NotBlank(message = "Name is required")
    @Size(min = 3, message = "Name must be at least 3 characters")
    private String name;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters")
    private String password;

    @NotBlank(message = "Role is required")
    private String role;

    @Min(value = 0, message = "Experience cannot be negative")
    private Integer experience;

    @Size(min = 3, message = "Specialization must be at least 3 characters")
    private String specialization;

    // getters
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public Integer getExperience() { return experience; }
    public String getSpecialization() { return specialization; }

    // setters
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setExperience(Integer experience) { this.experience = experience; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
}