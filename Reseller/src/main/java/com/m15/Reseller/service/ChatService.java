package com.m15.Reseller.service;

import com.m15.Reseller.dto.ChatDto;
import com.m15.Reseller.dto.exception.ChatNotFoundException;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.ChatRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;

@Service
@AllArgsConstructor
@Transactional
public class ChatService {
    private final ChatRepository chatRepository;
    private final UserRepository userRepository;

    public String save(ChatDto chatDto) {
        User firstUser = userRepository.findById(chatDto.getFirstUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        User secondUser = userRepository.findById(chatDto.getSecondUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        chatRepository.save(
                Chat.builder()
                        .firstUser(firstUser)
                        .secondUser(secondUser)
                        .build());

        return "Success";
    }


    public Chat getById(Long id) {
        Optional<Chat> chatOptional = chatRepository.findById(id);
        if (chatOptional.isPresent()) {
            return chatOptional.get();
        } else {
            throw new ChatNotFoundException("Chat ID not found");
        }
    }

    public HashSet<Chat> getChatByFirstUserName(String username) {
        HashSet<Chat> chat = chatRepository.getChatByFirstUsername(username);

        if (chat.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else {
            return chat;
        }
    }

    public HashSet<Chat> getChatBySecondUserName(String username) {
        HashSet<Chat> chat = chatRepository.getChatBySecondUsername(username);
        if (chat.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else {
            return chat;
        }
    }

    public HashSet<Chat> getChatByFirstUserNameOrSecondUserName(String username) {
        HashSet<Chat> chat = chatRepository.getChatByFirstUsername(username);
        HashSet<Chat> chat1 = chatRepository.getChatBySecondUsername(username);

        chat1.addAll(chat);

        if (chat.isEmpty() && chat1.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else if (chat1.isEmpty()) {
            return chat;
        } else {
            return chat1;
        }
    }

    public HashSet<Chat> getChatByFirstUserNameAndSecondUserName(String firstUserName, String secondUserName) {
        HashSet<Chat> chat = chatRepository.getChatByFirstUsernameAndSecondUsername(firstUserName, secondUserName);
        HashSet<Chat> chat1 = chatRepository.getChatBySecondUsernameAndFirstUsername(firstUserName, secondUserName);
        if (chat.isEmpty() && chat1.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else if (chat.isEmpty()) {
            return chat1;
        } else {
            return chat;
        }
    }
}
