package com.m15.Reseller.controller;

import com.m15.Reseller.dto.FollowDto;
import com.m15.Reseller.service.FollowService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/follow")
@AllArgsConstructor
public class FollowController {

    private final FollowService followService;

    @PostMapping
    public ResponseEntity<String> follow(@RequestBody FollowDto followDto) {
        return new ResponseEntity<>(followService.followProfile(followDto), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> unfollow(@PathVariable Long id) {
        return new ResponseEntity<>(followService.unfollowProfile(id), HttpStatus.MOVED_PERMANENTLY);
    }
}
