package com.m15.Reseller.service;

import com.m15.Reseller.dto.ChatDto;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.ChatRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

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


}
