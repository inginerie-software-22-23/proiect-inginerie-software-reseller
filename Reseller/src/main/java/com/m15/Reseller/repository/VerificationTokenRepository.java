package com.m15.Reseller.repository;

import com.m15.Reseller.model.VerificationToken;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
@Transactional
public interface VerificationTokenRepository  extends JpaRepository<VerificationToken, Long> {
    Optional<VerificationToken> findByToken(String token);
}
