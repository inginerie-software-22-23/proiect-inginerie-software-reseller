package com.m15.Reseller.controller;

import com.m15.Reseller.dto.CommentDto;
import com.m15.Reseller.service.CommentService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/comment")
@AllArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @PostMapping
    public ResponseEntity<String> createComment(@RequestBody CommentDto dto) {
        return new ResponseEntity<>(commentService.save(dto), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CommentDto> getComment(@PathVariable Long id) {

        return status(HttpStatus.OK).body(commentService.getComment(id));
    }

    @GetMapping
    public ResponseEntity<List<CommentDto>> getAllComments() {
        return status(HttpStatus.OK).body(commentService.getAllComments());
    }

    @GetMapping("by-user/{username}")
    public ResponseEntity<List<CommentDto>> getCommentsByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(commentService.getCommentsByUsername(username));
    }

    @GetMapping("by-post/{id}")
    public ResponseEntity<List<CommentDto>> getCommentsByPost(@PathVariable Long id) {
        return status(HttpStatus.OK).body(commentService.getCommentsByPost(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteComment(@PathVariable Long id) {
        return status(HttpStatus.MOVED_PERMANENTLY).body(commentService.deleteComment(id));
    }
}
