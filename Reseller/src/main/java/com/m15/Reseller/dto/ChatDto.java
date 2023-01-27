package com.m15.Reseller.dto;

import com.m15.Reseller.model.Message;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatDto {
    private Long chatId;
    private Long firstUserId;
    private Long secondUserId;
    private List<MessageDto> messages = new ArrayList<>();
}
