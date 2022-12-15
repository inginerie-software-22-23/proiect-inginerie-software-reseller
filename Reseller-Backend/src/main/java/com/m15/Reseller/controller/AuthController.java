package com.m15.Reseller.controller;

import com.m15.Reseller.dto.RegisterRequest;
import com.m15.Reseller.service.AuthService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@AllArgsConstructor
public class AuthController {
    private AuthService authService;

    @PostMapping("/register")
    public  ResponseEntity<String> register(@RequestBody RegisterRequest registerRequest) {
        return authService.register(registerRequest);
    }


}
