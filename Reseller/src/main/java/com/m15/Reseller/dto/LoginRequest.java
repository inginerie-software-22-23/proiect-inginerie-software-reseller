package com.m15.Reseller.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@EqualsAndHashCode
@ToString
public class LoginRequest {
    private String username;
    private String password;
}
