package com.m15.Reseller.controller;

import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.service.ProfileService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/profile")
@AllArgsConstructor
public class ProfileController {
    private final ProfileService profileService;
    @GetMapping
    public ResponseEntity<List<ProfileDto>> getAllProfiles() {
        return status(HttpStatus.OK).body(profileService.getAllProfiles());
    }

    @GetMapping("/{username}")
    public ResponseEntity<ProfileDto> getProfileByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(profileService.getProfileByUsername(username));
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<ProfileDto> getProfileById(@PathVariable Long id) {
        return status(HttpStatus.OK).body(profileService.getProfileById(id));
    }

    @GetMapping("/{username}/followers")
    public ResponseEntity<List<ProfileDto>> getFollowers(@PathVariable String username) {
        return status(HttpStatus.OK).body(profileService.getFollowers(username));
    }

    @GetMapping("/{username}/following")
    public ResponseEntity<List<ProfileDto>> getFollowing(@PathVariable String username) {
        return status(HttpStatus.OK).body(profileService.getFollowing(username));
    }

    @PostMapping("/{username}/profile-picture")
    public ResponseEntity<String> uploadProfilePicture(@PathVariable("username") String username, @RequestParam("file") MultipartFile file) {
        return status(HttpStatus.OK).body(profileService.uploadProfilePicture(username, file));
    }

    @GetMapping("/{username}/profile-picture")
    public ResponseEntity<byte[]> getProfilePicture(@PathVariable("username") String username) throws IOException {
        return status(HttpStatus.OK).body(profileService.getProfilePicture(username));
    }

    @PutMapping("/{username}/edit")
    public ResponseEntity<String> editProfile(@PathVariable("username") String username, @RequestBody ProfileDto profileDto, HttpServletRequest request) {
        return status(HttpStatus.OK).body(profileService.editProfile(username, profileDto, request));
    }

    @DeleteMapping("{id}")
    public ResponseEntity<String> deleteProfile(@PathVariable Long id) {
        return status(HttpStatus.MOVED_PERMANENTLY).body(profileService.deleteProfile(id));
    }
}
