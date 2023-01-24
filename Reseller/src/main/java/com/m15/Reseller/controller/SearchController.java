package com.m15.Reseller.controller;

import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.service.PostService;
import com.m15.Reseller.service.ProfileService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Set;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/search")
@AllArgsConstructor
public class SearchController {

    private final ProfileService profileService;
    private final PostService postService;

    @GetMapping("/profile/{username}")
    public ResponseEntity<List<ProfileDto>> searchProfile(@PathVariable String username) {
        return status(HttpStatus.OK).body(profileService.searchProfile(username));
    }

    @GetMapping("/post/{description}")
    public ResponseEntity<Set<PostResponse>> searchPost(@PathVariable String description) {
        return status(HttpStatus.OK).body(postService.searchPost(description));
    }
}
