package com.m15.Reseller.service;

import com.m15.Reseller.dto.FollowDto;
import com.m15.Reseller.dto.exception.FollowNotFound;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Follow;
import com.m15.Reseller.model.Notification;
import com.m15.Reseller.model.NotificationType;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.repository.FollowRepository;
import com.m15.Reseller.repository.NotificationRepository;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Objects;

@Service
@AllArgsConstructor
@Transactional
public class FollowService {

    private final FollowRepository followRepository;
    private final ProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;
    private final AuthService authService;

    public String followProfile(FollowDto followDto) {
        if (Objects.equals(authService.getCurrentUser().getUserId(), followDto.getFollowed())) {
            throw new SpringResellerException("You can't follow yourself!");
        }

        Profile follower = profileRepository.findByUser(authService.getCurrentUser())
                .orElseThrow(() -> new SpringResellerException("Profile ID not found!"));
        Profile followed = profileRepository.findById(followDto.getFollowed())
                .orElseThrow(() -> new  SpringResellerException("Profile ID not found!"));

        if (this.isFollowing(follower, followed)) {
            throw new SpringResellerException("Already following this account!");
        }

        Follow follow = new Follow();
        follow.setFollower(follower);
        follow.setFollowed(followed);
        followRepository.save(follow);

        Notification notification = new Notification();
        notification.setText(follower.getUsername() + " started following you");
        notification.setFlag(false);
        notification.setSender(follower.getUser());
        notification.setRecipient(followed.getUser());
        notification.setType(NotificationType.FOLLOW);
        notification.setTimestamp(LocalDateTime.now());
        notificationRepository.save(notification);

        return "Success";
    }

    public String unfollowProfile(FollowDto followDto) {
        if (Objects.equals(authService.getCurrentUser().getUserId(), followDto.getFollowed())) {
            throw new SpringResellerException("You can't unfollow yourself!");
        }

        Profile follower = profileRepository.findByUser(authService.getCurrentUser())
                .orElseThrow(() -> new SpringResellerException("Profile ID not found!"));
        Profile followed = profileRepository.findById(followDto.getFollowed())
                .orElseThrow(() -> new  SpringResellerException("Profile ID not found!"));

        Follow follow = followRepository.findByFollowerAndFollowed(follower, followed)
                .orElseThrow(() -> new FollowNotFound("Follow not found!"));

        followRepository.deleteById(follow.getId());
        return "Success";
    }

    private boolean isFollowing(Profile follower, Profile followed) {
        Follow follow = followRepository.findByFollowerAndFollowed(follower, followed)
                .orElse(null);
        return follow != null;
    }
}
