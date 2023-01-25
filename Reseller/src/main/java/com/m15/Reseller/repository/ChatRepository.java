package com.m15.Reseller.repository;

import com.m15.Reseller.dto.ChatDto;
import com.m15.Reseller.model.Chat;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.HashSet;
import java.util.Set;

@Repository
@Transactional
public interface ChatRepository extends JpaRepository<Chat, Long> {
    Set<Chat> getChatByFirstUser(User firstUser);
    Set<Chat> getChatBySecondUser(User secondUsername);
    Set<Chat> getChatByFirstUserAndSecondUser(User firstUser, User secondUser);
}
