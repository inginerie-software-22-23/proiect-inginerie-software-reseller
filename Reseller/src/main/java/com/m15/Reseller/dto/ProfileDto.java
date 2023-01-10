package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProfileDto {
    private Long id;
    private String username;
    private String fullName;
    private String description;
    private String imageUrl;
    private boolean isActive;
}
