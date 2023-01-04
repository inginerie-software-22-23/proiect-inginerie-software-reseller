package com.m15.Reseller.service;

import com.m15.Reseller.dto.PostRequest;
import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.PostRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class PostService {
    private final AuthService authService;
    private final PostRepository postRepository;
    private final UserRepository userRepository;
    public String save(PostRequest postRequest) {
        Post newPost = new Post();
        newPost.setImageUrl(postRequest.getImageUrl());
        newPost.setDescription(postRequest.getDescription());
        newPost.setTitle(postRequest.getTitle());
        newPost.setPrice(postRequest.getPrice());
        newPost.setUser(authService.getCurrentUser());
        newPost.setCreatedDate(Instant.now());
        postRepository.save(newPost);
        return "Success";
    }

    public PostResponse getPost(Long id) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException(id.toString()));
        return mapToDto(post);
    }

    public List<PostResponse> getAllPosts() {
        return postRepository.findAll()
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public List<PostResponse> getPostsByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        return postRepository.findByUser(user)
                .stream()
                .map(this::mapToDto)
                .collect(toList());
    }

    public PostResponse mapToDto(Post post) {
        PostResponse response = new PostResponse();
        response.setId(post.getPostId());
        response.setUsername(post.getUser().getUsername());
        response.setTitle(post.getTitle());
        response.setDescription(post.getDescription());
        response.setImageUrl(post.getImageUrl());
        response.setPrice(post.getPrice());
        return response;
    }
}
