package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationDto {
    private Long notificationId;
    private String text;
    private boolean isPost;
    private LocalDateTime timestamp;
}
