package com.m15.Reseller.controller;

import com.m15.Reseller.dto.NotificationDto;
import com.m15.Reseller.model.Notification;
import com.m15.Reseller.service.NotificationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notification")
@AllArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    @PostMapping
    public void createNotification(@RequestBody Notification notification) {
        notificationService.saveNotification(notification);
    }

    @GetMapping("/{username}")
    public List<NotificationDto> getNotificationsByUsername(@PathVariable String username) {
        return notificationService.getNotificationsByUsername(username);
    }
}
