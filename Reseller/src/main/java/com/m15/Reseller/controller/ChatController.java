package com.m15.Reseller.controller;

import com.m15.Reseller.dto.ChatDto;
import com.m15.Reseller.dto.PostRequest;
import com.m15.Reseller.dto.exception.ChatNotFoundException;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.service.ChatService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.Set;

@RestController
@RequestMapping("/api/chat")
@AllArgsConstructor
public class ChatController {
    private final ChatService chatService;

    @PostMapping
    public ResponseEntity<String> createChat(@RequestBody ChatDto chatDto) {
        return new ResponseEntity<>(chatService.save(chatDto), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ChatDto> getChatById(@PathVariable Long id) {
        try {
            return new ResponseEntity<ChatDto>(chatService.getById(id), HttpStatus.OK);
        } catch (ChatNotFoundException e) {
            return new ResponseEntity("Chat Not Found", HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/firstUsername/{username}")
    public ResponseEntity<?> getChatByFirstUserName(@PathVariable String username) {
        try {
            Set<ChatDto> byChat = this.chatService.getChatByFirstUserName(username);
            return new ResponseEntity<>(byChat, HttpStatus.OK);
        } catch (ChatNotFoundException e) {
            return new ResponseEntity("Chat Does Not Exist", HttpStatus.CONFLICT);
        }
    }



    @GetMapping("/secondUsername/{username}")
    public ResponseEntity<?> getChatBySecondUserName(@PathVariable String username) {

        try {
            Set<ChatDto> byChat = this.chatService.getChatBySecondUserName(username);
            return new ResponseEntity<>(byChat, HttpStatus.OK);
        } catch (ChatNotFoundException e) {
            return new ResponseEntity("Chat Does Not Exist", HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/getChatByFirstUsernameOrSecondUsername/{username}")
    public ResponseEntity<?> getChatByFirstUserNameOrSecondUserName(@PathVariable String username) {

        try {
            Set<ChatDto> byChat = this.chatService.getChatByFirstUserNameOrSecondUserName(username);
            return new ResponseEntity<>(byChat, HttpStatus.OK);
        } catch (ChatNotFoundException e) {
            return new ResponseEntity("Chat Does Not Exist", HttpStatus.CONFLICT);
        }
    }


    @GetMapping("/getChatByFirstUsernameAndSecondUsername")
    public ResponseEntity<?> getChatByFirstUserNameAndSecondUserName(@RequestParam("firstUsername") String firstUsername, @RequestParam("secondUsername") String secondUsername){

        try {
            Set<ChatDto> chatByBothUsers = this.chatService.getChatByFirstUsernameAndSecondUsername(firstUsername, secondUsername);
            return new ResponseEntity<>(chatByBothUsers, HttpStatus.OK);
        } catch (ChatNotFoundException e) {
            return new ResponseEntity("Chat Does Not Exist", HttpStatus.NOT_FOUND);
        }
    }
}
