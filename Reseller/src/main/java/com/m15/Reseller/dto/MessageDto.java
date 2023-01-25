package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageDto {
    private Long senderId;
    private Long recipientId;
    private Long chatId;
    private String text;
    private Instant createdDate = Instant.now();
}
