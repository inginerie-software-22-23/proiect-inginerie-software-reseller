package com.m15.Reseller.controller;

import com.m15.Reseller.dto.MessageDto;
import com.m15.Reseller.service.MessageService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/message")
@AllArgsConstructor
public class MessageController {
    private final MessageService messageService;

    @PostMapping
    public ResponseEntity<String> createMessage(@RequestBody MessageDto messageDto) {
        return new ResponseEntity<>(messageService.save(messageDto), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteMessage(@PathVariable Long id) {
        return new ResponseEntity<>(messageService.deleteMessage(id), HttpStatus.MOVED_PERMANENTLY);
    }

    @GetMapping("/sender/{id}")
    public ResponseEntity<List<MessageDto>> getMessagesBySender(@PathVariable Long id) {
        return status(HttpStatus.OK).body(messageService.getAllBySender(id));
    }

    @GetMapping("/recipient/{id}")
    public ResponseEntity<List<MessageDto>> getMessagesByRecipient(@PathVariable Long id) {
        return status(HttpStatus.OK).body(messageService.getAllByRecipient(id));
    }

    @GetMapping("/chat/{id}")
    public ResponseEntity<List<MessageDto>> getMessagesByChat(@PathVariable Long id) {
        return status(HttpStatus.OK).body(messageService.getAllByChat(id));
    }
}
