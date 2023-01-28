package com.m15.Reseller.controller;

import com.m15.Reseller.dto.LikeDto;
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
    @PostMapping("/comment")
    public ResponseEntity<String> likeComment(@RequestBody LikeDto likeDto) {
        return status(HttpStatus.OK).body(likesService.likeComment(likeDto));
    }
    @GetMapping("by-user/{username}")
    public ResponseEntity<List<LikeDto>> getLikesByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(likesService.getLikesByUsername(username));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> unlike(@PathVariable Long id) {
        return new ResponseEntity<>(likesService.unlike(id), HttpStatus.MOVED_PERMANENTLY);
    }

    @DeleteMapping("/comment/{id}")
    public ResponseEntity<String> unlikeComment(@PathVariable Long id) {
        return new ResponseEntity<>(likesService.unlikeComment(id), HttpStatus.MOVED_PERMANENTLY);
    }
}
