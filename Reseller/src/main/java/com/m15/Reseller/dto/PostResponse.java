package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostResponse {
    private Long id;
    private String title;
    private String imageUrl;
    private String description;
    private String username;
    private Integer price;
    private Integer likesCount;
    private Integer commentCount;
    private String age;

}
