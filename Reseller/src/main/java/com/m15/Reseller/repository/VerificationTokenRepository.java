package com.m15.Reseller.repository;

import com.m15.Reseller.model.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VerificationTokenRepository  extends JpaRepository<VerificationToken, Long> {
}
