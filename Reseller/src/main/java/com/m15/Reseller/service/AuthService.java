package com.m15.Reseller.service;

import com.m15.Reseller.config.JwtUtils;
import com.m15.Reseller.dto.AuthenticationResponse;
import com.m15.Reseller.dto.LoginRequest;
import com.m15.Reseller.dto.RegisterRequest;
import com.m15.Reseller.exception.SpringResellerException;
import com.m15.Reseller.helper.EmailSender;
import com.m15.Reseller.model.User;
import com.m15.Reseller.model.UserRole;
import com.m15.Reseller.model.VerificationToken;
import com.m15.Reseller.repository.UserRepository;
import com.m15.Reseller.repository.VerificationTokenRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
@AllArgsConstructor
public class AuthService {
    private final BCryptPasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final VerificationTokenRepository verificationTokenRepository;
    private final EmailSender emailSender;
    private final AuthenticationManager authenticationManager;
    private final JwtUtils jwtUtils;
    private final UserService userService;

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
        user.setUserRole(UserRole.USER);
        user.setCreated(Instant.now());
        user.setEnabled(false);

        userRepository.save(user);

        String token = generateVerificationToken(user);

        String link = "http://localhost:8070/api/auth/accountVerification/" + token;

        emailSender.send(
                registerRequest.getEmail(),
                emailSender.buildEmail(registerRequest.getUsername(), link));

        return new ResponseEntity<>("User Registration Successful", HttpStatus.OK);
    }

    @Transactional
    public ResponseEntity<String> login(LoginRequest loginRequest) {

        Authentication authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginRequest.getUsername(),
                loginRequest.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authenticate);

        String token = jwtUtils.generateToken((UserDetails) userRepository);
        final Optional<User> user = userRepository.findByUsername(loginRequest.getUsername());
        if (user.isPresent()) {
            return new ResponseEntity<>("User Login Successful\n Token: " + token, HttpStatus.OK);
        }
        return new ResponseEntity<>("Login failed", HttpStatus.BAD_REQUEST);
    }

    private String generateVerificationToken(User user) {
        String token = UUID.randomUUID().toString();
        VerificationToken verificationToken = new VerificationToken();
        verificationToken.setToken(token);
        verificationToken.setUser(user);

        verificationTokenRepository.save(verificationToken);
        return token;
    }

    public void verifyAccount(String token) {
        Optional<VerificationToken> verificationToken = verificationTokenRepository.findByToken(token);
        fetchUserAndEnable(verificationToken.orElseThrow(() -> new SpringResellerException("Invalid Token")));
    }

    private void fetchUserAndEnable(VerificationToken verificationToken) {
        String username = verificationToken.getUser().getUsername();
        User user = (User) userRepository.findByUsername(username).orElseThrow(() -> new SpringResellerException("User " + username + " not found"));
        user.setEnabled(true);
        userRepository.save(user);
    }


}
