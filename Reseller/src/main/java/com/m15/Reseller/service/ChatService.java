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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class ChatService {
    private final ChatRepository chatRepository;
    private final UserRepository userRepository;
    private final MessageService messageService;
    private final AuthService authService;

    public String save(ChatDto chatDto) {
        User firstUser = userRepository.findById(chatDto.getFirstUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        User secondUser = userRepository.findById(chatDto.getSecondUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        ChatDto dto = new ChatDto();
        dto.setFirstUserId(firstUser.getUserId());
        dto.setSecondUserId(secondUser.getUserId());
        Set<ChatDto> check = getChatByFirstUsernameAndSecondUsername(dto);
        if (!check.isEmpty()) {
            return "Chat between these users already exists";
        }

        chatRepository.save(
                Chat.builder()
                        .firstUser(firstUser)
                        .secondUser(secondUser)
                        .build());

        return "Success";
    }


    public ChatDto getById(Long id) {
        Optional<Chat> chatOptional = chatRepository.findById(id);
        if (chatOptional.isPresent()) {
            return mapToDto(chatOptional.get());
        } else {
            throw new ChatNotFoundException("Chat ID not found");
        }
    }

    public Set<ChatDto> getChatByFirstUserName(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));

        Set<ChatDto> chat = chatRepository.getChatByFirstUser(user).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());

        if (chat.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else {
            return chat;
        }
    }

    public Set<ChatDto> getChatBySecondUserName(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        Set<ChatDto> chat = chatRepository.getChatBySecondUser(user).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());
        if (chat.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else {
            return chat;
        }
    }

    public Set<ChatDto> getChatByFirstUserNameOrSecondUserName(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));

        Set<ChatDto> chat = chatRepository.getChatByFirstUser(user).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());;
        Set<ChatDto> chat1 = chatRepository.getChatBySecondUser(user).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());;

        chat1.addAll(chat);

        if (chat.isEmpty() && chat1.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else if (chat1.isEmpty()) {
            return chat;
        } else {
            return chat1;
        }
    }

    public Set<ChatDto> getChatByFirstUsernameAndSecondUsername(ChatDto chatDto) {
        User firstUser = userRepository.findById(chatDto.getFirstUserId())
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        User secondUser = userRepository.findById(chatDto.getSecondUserId())
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));

        Set<ChatDto> chat = chatRepository.getChatByFirstUserAndSecondUser(firstUser, secondUser).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());;
        Set<ChatDto> chat1 = chatRepository.getChatByFirstUserAndSecondUser(secondUser, firstUser).stream()
                .map(this::mapToDto)
                .collect(Collectors.toSet());
        if (chat.isEmpty() && chat1.isEmpty()) {
            throw new ChatNotFoundException("Chat with user provided not found");
        } else if (chat.isEmpty()) {
            return chat1;
        } else {
            return chat;
        }
    }

    private ChatDto mapToDto(Chat chat) {
        ChatDto dto = new ChatDto();
        dto.setChatId(chat.getChatId());
        dto.setFirstUserId(chat.getFirstUser().getUserId());
        dto.setSecondUserId(chat.getSecondUser().getUserId());
        dto.setMessages(chat.getMessages().stream().map(messageService::mapToDto).collect(Collectors.toList()));
        return dto;
    }
}
