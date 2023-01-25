package com.m15.Reseller.controller;

import com.m15.Reseller.dto.PostRequest;
import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.service.PostService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/post")
@AllArgsConstructor
public class PostController {
    private final PostService postService;

    @PostMapping
    public ResponseEntity<String> createPost(@RequestBody PostRequest postRequest) {
        return new ResponseEntity<>(postService.save(postRequest), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PostResponse> getPost(@PathVariable Long id) {
        return status(HttpStatus.OK).body(postService.getPost(id));
    }

    @GetMapping
    public ResponseEntity<List<PostResponse>> getAllPosts() {
        return status(HttpStatus.OK).body(postService.getAllPosts());
    }

    @GetMapping("/user/{username}")
    public ResponseEntity<List<PostResponse>> getPostsByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(postService.getPostsByUsername(username));
    }

    @GetMapping("/{id}/likes")
    public ResponseEntity<List<ProfileDto>> getLikesForPost(@PathVariable Long id) {
        return status(HttpStatus.OK).body(postService.getLikesForPost(id));
    }

    @PostMapping("/{id}/product-picture")
    public ResponseEntity<String> uploadProductPicture(@PathVariable("id") Long id, @RequestParam("file") MultipartFile file) {
        return status(HttpStatus.OK).body(postService.uploadProductPicture(id, file));
    }

    @GetMapping("/{id}/product-picture")
    public ResponseEntity<byte[]> getProductPicture(@PathVariable("id") Long id) throws IOException {
        return status(HttpStatus.OK).body(postService.getProductPicture(id));
    }
}
