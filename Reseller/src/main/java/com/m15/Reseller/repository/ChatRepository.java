package com.m15.Reseller.repository;

import com.m15.Reseller.model.Chat;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface ChatRepository extends JpaRepository<Chat, Long> {
}
