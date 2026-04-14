package com.healgo.backend.repository;

import com.healgo.backend.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    List<Appointment> findByProviderIdAndDate(Long providerId, LocalDate date);

    List<Appointment> findByProviderId(Long providerId);
}
