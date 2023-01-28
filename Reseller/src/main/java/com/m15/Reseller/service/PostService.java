package com.m15.Reseller.service;

import com.github.marlonlom.utilities.timeago.TimeAgo;
import com.m15.Reseller.dto.PostRequest;
import com.m15.Reseller.dto.PostResponse;
import com.m15.Reseller.dto.ProfileDto;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.LikesRepository;
import com.m15.Reseller.repository.PostRepository;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class PostService {
    private final AuthService authService;
    private final PostRepository postRepository;
    private final UserRepository userRepository;
    private final LikesRepository likesRepository;
    private final ProfileRepository profileRepository;
    private final ProfileService profileService;
    private final FirebaseStorageService storageService;

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

    public List<ProfileDto> getLikesForPost(Long id) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException(id.toString()));

        List<Likes> likes = likesRepository.findAllByPost(post);
        List<Profile> profiles = new LinkedList<>();

        for (Likes like: likes) {
            profiles.add(profileRepository.findByUsername(like.getUser().getUsername())
                    .orElseThrow(() -> new SpringResellerException("Profile not found!")));
        }

        return profiles.stream()
                .map(profileService::mapToDto)
                .collect(toList());
    }

    private PostResponse mapToDto(Post post) {
        PostResponse response = new PostResponse();
        response.setId(post.getPostId());
        response.setUsername(post.getUser().getUsername());
        response.setTitle(post.getTitle());
        response.setDescription(post.getDescription());
        response.setImageUrl(post.getImageUrl());
        response.setPrice(post.getPrice());
        response.setCommentCount(post.getCommentCount());
        response.setLikesCount(post.getLikesCount());
        response.setSavedCount(post.getSavedCount());
        response.setAge(TimeAgo.using(post.getCreatedDate().toEpochMilli()));
        return response;
    }

    public String uploadProductPicture(Long id, MultipartFile file) {
        String productUrl = storageService.storeFile(file, "product-images/");
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException("Post not found!"));

        post.setImageUrl(productUrl);
        postRepository.save(post);
        return "Success";
    }

    public String getProductPicture(Long id) throws IOException {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new SpringResellerException("Post not found!"));

        return "https://firebasestorage.googleapis.com/v0/b/reseller-1d2c9.appspot.com/o/" +
                post.getImageUrl().replace("/", "%2F") +
                "?alt=media&token=" +
                post.getImageUrl();

    }

    public Set<PostResponse> searchPost(String description) {
        return Stream.concat(postRepository.findByDescriptionContainingIgnoreCase(description).stream(),
                        postRepository.findByTitleContainingIgnoreCase(description).stream())
                .map(this::mapToDto)
                .collect(Collectors.toSet());
    }
}
