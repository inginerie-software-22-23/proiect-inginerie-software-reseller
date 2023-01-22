package com.m15.Reseller.service;

import com.m15.Reseller.dto.FollowDto;
import com.m15.Reseller.dto.exception.FollowNotFound;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Follow;
import com.m15.Reseller.model.Notification;
import com.m15.Reseller.model.NotificationType;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.FollowRepository;
import com.m15.Reseller.repository.NotificationRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Objects;

@Service
@AllArgsConstructor
@Transactional
public class FollowService {

    private final FollowRepository followRepository;
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;
    private final AuthService authService;

    public String followUser(FollowDto followDto) {
        if (Objects.equals(authService.getCurrentUser().getUserId(), followDto.getFollowed())) {
            throw new SpringResellerException("You can't follow yourself!");
        }

        User follower = userRepository.findById(authService.getCurrentUser().getUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));
        User followed = userRepository.findById(followDto.getFollowed())
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));

        if (this.isFollowing(follower, followed)) {
            throw new SpringResellerException("Already following this account!");
        }

        Follow follow = new Follow();
        follow.setFollower(follower);
        follow.setFollowed(followed);
        followRepository.save(follow);

        Notification notification = new Notification();
        notification.setText(follower.getUsername() + " started following you");
        notification.setPost(false);
        notification.setSender(follower);
        notification.setRecipient(followed);
        notification.setType(NotificationType.FOLLOW);
        notification.setTimestamp(LocalDateTime.now());
        notificationRepository.save(notification);

        return "Success";
    }

    public String unfollowUser(FollowDto followDto) {
        if (Objects.equals(authService.getCurrentUser().getUserId(), followDto.getFollowed())) {
            throw new SpringResellerException("You can't unfollow yourself!");
        }

        User follower = userRepository.findById(authService.getCurrentUser().getUserId())
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));
        User followed = userRepository.findById(followDto.getFollowed())
                .orElseThrow(() -> new UsernameNotFoundException("User ID not found!"));

        Follow follow = followRepository.findByFollowerAndFollowed(follower, followed)
                .orElseThrow(() -> new FollowNotFound("Follow not found!"));

        followRepository.deleteById(follow.getId());
        return "Success";
    }

    private boolean isFollowing(User follower, User followed) {
        Follow follow = followRepository.findByFollowerAndFollowed(follower, followed)
                .orElse(null);
        return follow != null;
    }
}
