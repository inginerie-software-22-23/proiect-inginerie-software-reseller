package com.m15.Reseller.repository;

import com.m15.Reseller.model.Chat;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.HashSet;

@Repository
@Transactional
public interface ChatRepository extends JpaRepository<Chat, Long> {
    HashSet<Chat> getChatByFirstUsername(String firstUsername);
    HashSet<Chat> getChatBySecondUsername(String secondUsername);
    HashSet<Chat> getChatByFirstUsernameAndSecondUsername(String firstUsername, String secondUsername);
    HashSet<Chat> getChatBySecondUsernameAndFirstUsername(String firstUsername, String secondUsername);
}
