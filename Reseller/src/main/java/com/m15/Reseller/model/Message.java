package com.m15.Reseller.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

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
    @OneToOne()
    @JoinColumn(name = "senderId", referencedColumnName = "userId")
    private User sender;
    @OneToOne()
    @JoinColumn(name = "recipientId", referencedColumnName = "userId")
    private User recipient;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "chat_id")
    private Chat chat;
    private String text;
    private Instant createdDate = Instant.now();
}
