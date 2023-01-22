package com.m15.Reseller.service;

import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Follow;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.FollowRepository;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class ProfileService {
    private final ProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final FirebaseStorageService storageService;

    public List<ProfileDto> getAllProfiles() {
        return profileRepository.findAll()
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public ProfileDto getProfileByUsername(String username) {
        return mapToDto(profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("Profile not found!")));
    }

    public List<ProfileDto> getFollowing(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        List<Follow> follows = followRepository.findAllByFollower(user);
        List<Profile> profiles = new LinkedList<>();
        for (Follow follow : follows) {
            profiles.add(profileRepository.findById(follow.getFollowed().getUserId())
                    .orElseThrow(() -> new SpringResellerException("Profile not found!")));
        }

        return profiles.stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<ProfileDto> getFollowers(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));

        List<Follow> follows = followRepository.findAllByFollowed(user);
        List<Profile> profiles = new LinkedList<>();
        for (Follow follow : follows) {
            profiles.add(profileRepository.findByUser(follow.getFollower())
                    .orElseThrow(() -> new SpringResellerException("Profile not found!")));
        }

        return profiles.stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public ProfileDto mapToDto(Profile profile) {
        ProfileDto profileDto = new ProfileDto();
        profileDto.setId(profile.getProfileId());
        profileDto.setUsername(profile.getUsername());
        profileDto.setDescription(profile.getDescription());
        profileDto.setFullName(profile.getFullName());
        profileDto.setImageUrl(profile.getImageUrl());
        profileDto.setActive(profile.isActive());
        return profileDto;
    }

    public String uploadProfilePicture(String username, MultipartFile file) {
        String profilePictureUrl = storageService.storeFile(file);
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("User not found!"));

        profile.setImageUrl(profilePictureUrl);
        profileRepository.save(profile);
        return "Success";
    }

    public byte[] getProfilePicture(String username) throws IOException {
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("User not found!"));
        return storageService.getFile(profile.getImageUrl());
    }
}
