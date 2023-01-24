package com.m15.Reseller.service;

import com.m15.Reseller.config.JwtUtils;
import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Follow;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.FollowRepository;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class ProfileService {
    private final ProfileRepository profileRepository;
    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final UserService userService;
    private final AuthService authService;
    private final FirebaseStorageService storageService;
    private final JwtUtils jwtUtils;

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
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("Profile not found!"));
        List<Follow> follows = followRepository.findAllByFollower(profile);
        List<Profile> profiles = new LinkedList<>();
        for (Follow follow : follows) {
            profiles.add(profileRepository.findById(follow.getFollowed().getProfileId())
                    .orElseThrow(() -> new SpringResellerException("Profile not found!")));
        }

        return profiles.stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<ProfileDto> getFollowers(String username) {
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("Profile not found!"));

        List<Follow> follows = followRepository.findAllByFollowed(profile);
        List<Profile> profiles = new LinkedList<>();
        for (Follow follow : follows) {
            profiles.add(profileRepository.findById(follow.getFollower().getProfileId())
                    .orElseThrow(() -> new SpringResellerException("Profile not found!")));
        }

        return profiles.stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public ProfileDto mapToDto(Profile profile) {
        ProfileDto profileDto = new ProfileDto();
        profileDto.setProfileId(profile.getProfileId());
        profileDto.setUsername(profile.getUsername());
        profileDto.setUserId(profile.getUser().getUserId());
        profileDto.setDescription(profile.getDescription());
        profileDto.setFullName(profile.getFullName());
        profileDto.setImageUrl(profile.getImageUrl());
        profileDto.setActive(profile.isActive());
        return profileDto;
    }

    public String uploadProfilePicture(String username, MultipartFile file) {
        String profilePictureUrl = storageService.storeFile(file, "profile-pictures/");
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("User not found!"));

        profile.setImageUrl(profilePictureUrl);
        profileRepository.save(profile);
        return "Success";
    }

    public List<ProfileDto> searchProfile(String username) {
        return profileRepository.findByUsernameStartingWith(username).stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public byte[] getProfilePicture(String username) throws IOException {
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("User not found!"));
        return storageService.getFile(profile.getImageUrl());
    }

    public ProfileDto getProfileById(Long id) {
        return mapToDto(profileRepository.findById(id)
                .orElseThrow(() -> new SpringResellerException("Profile not found!")));
    }

    public String editProfile(String username, ProfileDto profileDto, HttpServletRequest request) {
        Profile profile = profileRepository.findByUsername(username)
                .orElseThrow(() -> new SpringResellerException("Profile not found!"));

        String newToken = "Success";
        String newUsername = profileDto.getUsername();
        String oldUsername = profile.getUser().getUsername();
        if (Objects.equals(updateField(oldUsername, newUsername), newUsername)) {
            userService.editUsername(profile.getUser(), newUsername);
            profile.setUsername(newUsername);
            HttpSession session = request.getSession();
            session.removeAttribute("jwt");
            newToken = jwtUtils.generateToken(profile.getUser());
            session.setAttribute("jwt", newToken);

        }
        profile.setImageUrl(updateField(profile.getImageUrl(), profileDto.getImageUrl()));
        profile.setDescription(updateField(profile.getDescription(), profileDto.getDescription()));
        profile.setFullName(updateField(profile.getFullName(), profileDto.getFullName()));
        profileRepository.save(profile);
        return newToken;
    }

    private String updateField(String oldValue, String newValue) {
        if (newValue != null && !newValue.equals("") && !Objects.equals(oldValue, newValue)) {
            return newValue;
        }

        return oldValue;
    }

    public String deleteProfile(Long id) {
        Profile profile = profileRepository.findById(id)
                .orElseThrow(() -> new SpringResellerException("Profile not found!"));

        if (authService.getCurrentUser().equals(profile.getUser())) {
            userRepository.deleteById(authService.getCurrentUser().getUserId());
            return "Deleted";
        }
        return "Error";
    }
}
