package com.m15.Reseller.repository;

import com.m15.Reseller.model.Notification;
import com.m15.Reseller.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    Optional<Notification> findByRecipient(User user);
}