package com.healgo.backend.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Data
@Table(name = "appointment")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonProperty("userId")       // 🔥 FIX
    private Long userId;

    @JsonProperty("providerId")   // 🔥 FIX
    private Long providerId;

    private String serviceName;
    private String status;
    private LocalDate date;
    private LocalTime time;
}