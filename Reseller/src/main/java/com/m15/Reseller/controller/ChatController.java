package com.m15.Reseller.controller;

import com.m15.Reseller.dto.ChatDto;
import com.m15.Reseller.dto.PostRequest;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.service.ChatService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;

@RestController
@RequestMapping("/api/chat")
@AllArgsConstructor
public class ChatController {
    private final ChatService chatService;

    @PostMapping
    public ResponseEntity<String> createChat(@RequestBody ChatDto chatDto) {
        return new ResponseEntity<>(chatService.save(chatDto), HttpStatus.CREATED);
    }
}
