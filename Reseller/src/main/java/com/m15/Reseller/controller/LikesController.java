package com.m15.Reseller.controller;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.service.LikesService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
