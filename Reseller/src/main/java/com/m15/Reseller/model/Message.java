package com.m15.Reseller.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Entity
@Builder
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long messageId;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "senderId", referencedColumnName = "userId")
    private User sender;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipientId", referencedColumnName = "userId")
    private User recipient;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "chat_id")
    private Chat chat;
    private String text;
    private Instant createdDate = Instant.now();
}
