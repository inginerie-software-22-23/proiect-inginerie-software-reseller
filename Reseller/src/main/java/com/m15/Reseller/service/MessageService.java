package com.m15.Reseller.service;

import com.m15.Reseller.dto.MessageDto;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.model.Message;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.ChatRepository;
import com.m15.Reseller.repository.MessageRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.checkerframework.checker.units.qual.C;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class MessageService {
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;
    private final ChatRepository chatRepository;
    private final AuthService authService;

    public String save(MessageDto messageDto) {
        User recipient = userRepository.findById(messageDto.getRecipientId())
                        .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        Optional<Chat> chatOptional = chatRepository.findById(messageDto.getChatId());
        Chat chat = chatOptional.orElseGet(() -> Chat.builder()
                .firstUser(authService.getCurrentUser())
                .secondUser(recipient)
                .build());

        messageRepository.save(
                Message.builder()
                        .sender(authService.getCurrentUser())
                        .recipient(recipient)
                        .chat(chat)
                        .text(messageDto.getText())
                        .build());

        return "Success";
    }


    public String deleteMessage(Long id) {
        Message message = messageRepository.findById(id)
                .orElseThrow(() -> new SpringResellerException("Message not found"));

        if (authService.getCurrentUser().equals(message.getSender())) {
            messageRepository.delete(message);
            return "Deleted";
        }

        return "Error";
    }

    public List<MessageDto> getAllBySender(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));

        return messageRepository.findAllBySender(user)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<MessageDto> getAllByRecipient(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));

        return messageRepository.findAllByRecipient(user)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<MessageDto> getAllByChat(Long id) {
        Chat chat = chatRepository.findById(id)
                .orElseThrow(() -> new SpringResellerException("Chat ID not found!"));

        return messageRepository.findAllByChat(chat)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    private MessageDto mapToDto(Message message) {
        MessageDto dto = new MessageDto();
        dto.setText(message.getText());
        dto.setRecipientId(message.getRecipient().getUserId());
        dto.setSenderId(message.getSender().getUserId());
        return dto;
    }
}
