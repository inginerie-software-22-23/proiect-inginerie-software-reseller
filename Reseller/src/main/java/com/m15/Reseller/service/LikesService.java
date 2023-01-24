package com.m15.Reseller.service;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.*;
import com.m15.Reseller.repository.*;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
@Transactional
public class LikesService {
    private final PostRepository postRepository;
    private final LikesRepository likesRepository;
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;
    private final CommentRepository commentRepository;
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

        if (authService.getCurrentUser() != post.getUser()) {
            Notification notification = new Notification();
            notification.setText(authService.getCurrentUser().getUsername() + " just liked your post");
            notification.setFlag(true);
            notification.setSender(authService.getCurrentUser());
            notification.setRecipient(post.getUser());
            notification.setInteractionPost(post);
            notification.setType(NotificationType.LIKE);
            notification.setTimestamp(LocalDateTime.now());
            notificationRepository.save(notification);
        }

        return "Success";
    }

    public String likeComment(LikeDto likeDto) {
        Comment comment = commentRepository.findById(likeDto.getCommentId())
                .orElseThrow(() -> new SpringResellerException("Comment with id " + likeDto.getCommentId() + " not found!"));

        Optional<Likes> likeByCommentAndUser = likesRepository.findTopByCommentAndUserOrderByLikeIdDesc(comment, authService.getCurrentUser());

        if (likeByCommentAndUser.isPresent()) {
            throw new SpringResellerException("You have already liked this comment!");
        }

        comment.setLikesCount(comment.getLikesCount() + 1);
        likesRepository.save(mapToLike(likeDto, comment));
        commentRepository.save(comment);

        if (authService.getCurrentUser() != comment.getUser()) {
            Notification notification = new Notification();
            notification.setText(authService.getCurrentUser().getUsername() + " just liked your comment");
            notification.setFlag(true);
            notification.setSender(authService.getCurrentUser());
            notification.setRecipient(comment.getUser());
            notification.setInteractionPost(comment.getPost());
            notification.setType(NotificationType.LIKE);
            notification.setTimestamp(LocalDateTime.now());
            notificationRepository.save(notification);
        }

        return "Success";
    }

    public List<LikeDto> getLikesByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        return likesRepository.findByUser(user)
                .stream()
                .map(this::mapToDto)
                .toList();
    }

    public String unlike(Long id) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException("Post with id " + id + " not found!"));

        Optional<Likes> likeByPostAndUser = likesRepository.findTopByPostAndUserOrderByLikeIdDesc(post, authService.getCurrentUser());

        if (likeByPostAndUser.isEmpty()) {
            throw new SpringResellerException("You didn't like this post yet!");
        }

        likesRepository.deleteById(likeByPostAndUser.get().getLikeId());
        post.setLikesCount(post.getLikesCount() - 1);
        return "Deleted";
    }

    private LikeDto mapToDto(Likes likes) {
        LikeDto dto = new LikeDto();
        dto.setPostId(likes.getPost().getPostId());
        dto.setCommentId(likes.getComment().getCommentId());
        return dto;
    }

    private Likes mapToLike(LikeDto likeDto, Post post) {
        return Likes.builder()
                .post(post)
                .user(authService.getCurrentUser())
                .build();
    }

    private Likes mapToLike(LikeDto likeDto, Comment comment) {
        return Likes.builder()
                .comment(comment)
                .user(authService.getCurrentUser())
                .build();
    }
}
