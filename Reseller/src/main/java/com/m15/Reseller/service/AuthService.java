package com.m15.Reseller.service;

import com.m15.Reseller.config.JwtUtils;
import com.m15.Reseller.dto.AuthenticationResponse;
import com.m15.Reseller.dto.LoginRequest;
import com.m15.Reseller.dto.RefreshTokenRequest;
import com.m15.Reseller.dto.RegisterRequest;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.helper.EmailSender;
import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import com.m15.Reseller.model.UserRole;
import com.m15.Reseller.model.VerificationToken;
import com.m15.Reseller.repository.ProfileRepository;
import com.m15.Reseller.repository.UserRepository;
import com.m15.Reseller.repository.VerificationTokenRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
@AllArgsConstructor
@Transactional
public class AuthService {
    private final BCryptPasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final VerificationTokenRepository verificationTokenRepository;
    private final EmailSender emailSender;
    private final AuthenticationManager authenticationManager;
    private final JwtUtils jwtUtils;
    private final UserService userService;
    private final RefreshTokenService refreshTokenService;

    public ResponseEntity<String> register(RegisterRequest registerRequest) {

        boolean userExists = userRepository
                .findByEmail(registerRequest.getEmail())
                .isPresent();

        boolean nameTaken = userRepository
                .findByUsername(registerRequest.getUsername())
                .isPresent();

        if (userExists) {
            return new ResponseEntity<>("This email is already in use", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        if (nameTaken) {
            return new ResponseEntity<>("This username is already in use", HttpStatus.INTERNAL_SERVER_ERROR);
        }



        User user = new User();
        user.setUsername(registerRequest.getUsername());
        user.setEmail(registerRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        user.setUserRole(UserRole.USER);
        user.setCreated(Instant.now());
        user.setEnabled(false);

        userRepository.save(user);

        Profile profile = new Profile();
        profile.setDescription("New to Reseller");
        profile.setUsername(user.getUsername());
        profile.setUser(user);
        profile.setFullName(registerRequest.getFullName());

        profileRepository.save(profile);

        String token = generateVerificationToken(user);

        String link = "http://localhost:8070/api/auth/accountVerification/" + token;

        emailSender.send(
                registerRequest.getEmail(),
                emailSender.buildAuthEmail(registerRequest.getUsername(), link), "Confirm your email");

        return new ResponseEntity<>("User Registration Successful", HttpStatus.OK);
    }

    public AuthenticationResponse authenticate(LoginRequest request) {
        Authentication auth = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
        );

        final User user = userService.loadUserByUsername(request.getUsername());
        String token = jwtUtils.generateToken(user);
        SecurityContextHolder.getContext().setAuthentication(auth);
        return AuthenticationResponse.builder()
                .authenticationToken(token)
                .refreshToken(refreshTokenService.generateRefreshToken().getToken())
                .expiresAt(jwtUtils.extractExpiration(token))
                .username(request.getUsername())
                .build();
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
        User user = userRepository.findByUsername(username).orElseThrow(() -> new SpringResellerException("User " + username + " not found"));
        user.setEnabled(true);
        userRepository.save(user);
    }


    public AuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {
        refreshTokenService.validateRefreshToken(refreshTokenRequest.getRefreshToken());
        String token = jwtUtils.generateToken(userService.loadUserByUsername(refreshTokenRequest.getUsername()));
        return AuthenticationResponse.builder()
                .authenticationToken(token)
                .refreshToken(refreshTokenRequest.getRefreshToken())
                .expiresAt(jwtUtils.extractExpiration(token))
                .username(refreshTokenRequest.getUsername())
                .build();
    }


    public User getCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userRepository.findByUsername(user.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
    }
}
