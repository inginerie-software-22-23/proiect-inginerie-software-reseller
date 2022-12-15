package com.m15.Reseller.service;

import com.m15.Reseller.dto.RegisterRequest;
import com.m15.Reseller.model.User;
import com.m15.Reseller.model.VerificationToken;
import com.m15.Reseller.repository.UserRepository;
import com.m15.Reseller.repository.VerificationTokenRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.UUID;

@Service
@AllArgsConstructor
public class AuthService {
    private final BCryptPasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final VerificationTokenRepository verificationTokenRepository;

    @Transactional
    public ResponseEntity<String> register(RegisterRequest registerRequest) {

        boolean userExists = userRepository
                .findByEmail(registerRequest.getEmail())
                .isPresent();

        if (userExists) {
            return new ResponseEntity<>("This email is already in use", HttpStatus.OK);
        }

        User user = new User();
        user.setUsername(registerRequest.getUsername());
        user.setEmail(registerRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        user.setCreated(Instant.now());
        user.setEnabled(false);

        userRepository.save(user);

        generateVerificationToken(user);

        return new ResponseEntity<>("User Registration Successful", HttpStatus.OK);
    }

    private String generateVerificationToken(User user) {
        String token = UUID.randomUUID().toString();
        VerificationToken verificationToken = new VerificationToken();
        verificationToken.setToken(token);
        verificationToken.setUser(user);

        verificationTokenRepository.save(verificationToken);
        return token;
    }
}
