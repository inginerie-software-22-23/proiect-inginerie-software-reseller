package com.m15.Reseller.controller;

import com.m15.Reseller.dto.FollowDto;
import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.service.LikesService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/likes")
@AllArgsConstructor
public class LikesController {
    private final LikesService likesService;

    @PostMapping
    public ResponseEntity<String> like(@RequestBody LikeDto likeDto) {
        return status(HttpStatus.OK).body(likesService.likePost(likeDto));
    }
    @GetMapping("by-user/{username}")
    public ResponseEntity<List<LikeDto>> getLikesByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(likesService.getLikesByUsername(username));
    }

    @DeleteMapping()
    public ResponseEntity<String>  unlike(@RequestBody LikeDto likeDto) {
        return new ResponseEntity<>(likesService.unlike(likeDto), HttpStatus.OK);
    }
}
