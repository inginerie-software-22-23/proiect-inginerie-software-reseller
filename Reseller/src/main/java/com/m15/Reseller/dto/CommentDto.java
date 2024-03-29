package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDto {
    private Long commentId;
    private Long postId;
    private Instant createdDate;
    private String text;
    private String username;
    private Integer likesCount = 0;
}
