package com.m15.Reseller.service;

import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.RefreshToken;
import com.m15.Reseller.repository.RefereshTokenRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
@AllArgsConstructor
@Transactional
public class RefreshTokenService {

    private final RefereshTokenRepository refereshTokenRepository;

    public RefreshToken generateRefreshToken() {
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setToken(UUID.randomUUID().toString());
        refreshToken.setCreatedDate(Instant.now());

        return refereshTokenRepository.save(refreshToken);
    }

    public void validateRefreshToken(String token) {
        refereshTokenRepository.findByToken(token)
                .orElseThrow(() -> new SpringResellerException("Invalid refresh token!"));
    }

    public void deleteRefreshToken(String token) {
        refereshTokenRepository.deleteByToken(token);
    }
}
