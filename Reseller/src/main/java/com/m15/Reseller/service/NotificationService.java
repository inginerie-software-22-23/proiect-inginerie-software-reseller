package com.m15.Reseller.service;

import com.m15.Reseller.dto.NotificationDto;
import com.m15.Reseller.model.Notification;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.NotificationRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class NotificationService {
    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    public void saveNotification(Notification notification) {
        notificationRepository.save(notification);
    }

    public List<NotificationDto> getNotificationsByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        return notificationRepository.findByRecipient(user)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    private NotificationDto mapToDto(Notification notification) {
        NotificationDto notificationDto = new NotificationDto();
        notificationDto.setNotificationId(notification.getNotificationId());
        notificationDto.setText(notification.getText());
        notificationDto.setPost(notification.isPost());
        notificationDto.setTimestamp(notification.getTimestamp());
        return notificationDto;
    }
}
