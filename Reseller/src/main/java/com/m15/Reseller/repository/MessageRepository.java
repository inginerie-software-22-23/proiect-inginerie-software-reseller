package com.m15.Reseller.repository;

import com.m15.Reseller.model.Chat;
import com.m15.Reseller.model.Message;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
@Transactional
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findAllBySender(User sender);
    List<Message> findAllByRecipient(User recipient);
    List<Message> findAllByChat(Chat chat);
}
