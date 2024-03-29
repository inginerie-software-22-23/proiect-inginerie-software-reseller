package com.m15.Reseller.service;

import com.m15.Reseller.dto.CommentDto;
import com.m15.Reseller.dto.exception.CommentNotFoundException;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.helper.EmailSender;
import com.m15.Reseller.model.*;
import com.m15.Reseller.repository.CommentRepository;
import com.m15.Reseller.repository.NotificationRepository;
import com.m15.Reseller.repository.PostRepository;
import com.m15.Reseller.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Transactional
public class CommentService {
    private final PostRepository postRepository;
    private final UserRepository userRepository;
    private final AuthService authService;
    private final CommentRepository commentRepository;
    private final EmailSender emailSender;
    private final NotificationRepository notificationRepository;

    public String save(CommentDto dto) {
        Post post = postRepository.findById(dto.getPostId())
                .orElseThrow(() -> new PostNotFoundException(dto.getPostId().toString()));
        Comment comment = new Comment();
        comment.setText(dto.getText());
        comment.setPost(post);
        comment.setUser(authService.getCurrentUser());
        comment.setCreatedDate(Instant.now());
        commentRepository.save(comment);
        post.setCommentCount(post.getCommentCount() + 1);
        postRepository.save(post);

        emailSender.send(post.getUser().getEmail(),
                emailSender.buildCommentNotificationEmail(post.getUser(), dto.getText()), "New comment on your post");

        if (authService.getCurrentUser() != post.getUser()) {
            Notification notification = new Notification();
            notification.setText(authService.getCurrentUser().getUsername() + " just commented on your post");
            notification.setFlag(true);
            notification.setSender(authService.getCurrentUser());
            notification.setRecipient(post.getUser());
            notification.setInteractionPost(post);
            notification.setType(NotificationType.COMMENT);
            notification.setTimestamp(LocalDateTime.now());
            notificationRepository.save(notification);
        }

        return "Success";
    }

    public CommentDto getComment(Long id) {
        Comment comment = commentRepository.findById(id)
                .orElseThrow(() -> new CommentNotFoundException(id.toString()));

        return mapToDto(comment);
    }

    public List<CommentDto> getAllComments() {
        return commentRepository.findAll()
                .stream()
                .map(this::mapToDto)
                .collect(Collectors.toList());
    }

    public List<CommentDto> getCommentsByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username));

        return commentRepository.findByUser(user)
                .stream()
                .map(this::mapToDto)
                .collect(Collectors.toList());
    }

    public List<CommentDto> getCommentsByPost(Long postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new PostNotFoundException(postId.toString()));

        return commentRepository.findByPost(post)
                .stream()
                .map(this::mapToDto)
                .collect(Collectors.toList());
    }


    private CommentDto mapToDto(Comment comment) {
        CommentDto dto = new CommentDto();
        dto.setCommentId(comment.getCommentId());
        dto.setCreatedDate(comment.getCreatedDate());
        dto.setPostId(comment.getPost().getPostId());
        dto.setUsername(comment.getUser().getUsername());
        dto.setText(comment.getText());
        return dto;
    }

    public String deleteComment(Long id) {
        Comment comment = commentRepository.findById(id)
                .orElseThrow(() -> new CommentNotFoundException(id.toString()));

        if (authService.getCurrentUser().equals(comment.getUser())) {
            commentRepository.delete(comment);
            return "Deleted";
        }
        return "Error";
    }
}
