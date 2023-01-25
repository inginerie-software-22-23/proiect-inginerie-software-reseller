package com.m15.Reseller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProfileDto {
    private Long profileId;
    private String username;
    private Long userId;
    private String fullName = "";
    private String description = "";
    private String imageUrl = "";
    private boolean isActive = false;
}
