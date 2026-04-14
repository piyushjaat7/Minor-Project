package com.healgo.backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String specialization;
    private int experience;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;   // ✅ FIXED
}