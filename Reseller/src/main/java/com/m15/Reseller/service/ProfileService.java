package com.m15.Reseller.service;

import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class ProfileService {
    private final ProfileRepository profileRepository;
    private final UserRepository userRepository;

    public List<ProfileDto> getAllProfiles() {
        return profileRepository.findAll()
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<ProfileDto> getProfilesByUsername(String username) {
        return profileRepository.findByUsernameStartingWith(username)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    private ProfileDto mapToDto(Profile profile) {
        ProfileDto profileDto = new ProfileDto();
        profileDto.setId(profile.getProfileId());
        profileDto.setUsername(profile.getUsername());
        profileDto.setDescription(profileDto.getDescription());
        profileDto.setFullName(profile.getFullName());
        profileDto.setImageUrl(profile.getImageUrl());
        profileDto.setActive(profileDto.isActive());
        return profileDto;
    }
}
