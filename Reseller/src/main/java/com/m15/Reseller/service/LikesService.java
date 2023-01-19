package com.m15.Reseller.service;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import com.m15.Reseller.repository.LikesRepository;
import com.m15.Reseller.repository.PostRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static java.util.stream.Collectors.toList;

@Service
@AllArgsConstructor
@Transactional
public class LikesService {
    private final PostRepository postRepository;
    private final LikesRepository likesRepository;
    private final UserRepository userRepository;
    private final AuthService authService;
    public String likePost(LikeDto likeDto) {
        Post post = postRepository.findById(likeDto.getPostId())
                .orElseThrow(() -> new PostNotFoundException("Post with id " + likeDto.getPostId() + " not found!"));

        Optional<Likes> likeByPostAndUser = likesRepository.findTopByPostAndUserOrderByLikeIdDesc(post, authService.getCurrentUser());

        if (likeByPostAndUser.isPresent()) {
            throw new SpringResellerException("You have already liked this post!");
        }

        post.setLikesCount(post.getLikesCount() + 1);
        likesRepository.save(mapToLike(likeDto, post));
        postRepository.save(post);
        return "Success";
    }

    private Likes mapToLike(LikeDto likeDto, Post post) {
        return Likes.builder()
                .post(post)
                .user(authService.getCurrentUser())
                .build();
    }

    public List<LikeDto> getLikesByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        return likesRepository.findByUser(user).stream().toList();
    }
}
