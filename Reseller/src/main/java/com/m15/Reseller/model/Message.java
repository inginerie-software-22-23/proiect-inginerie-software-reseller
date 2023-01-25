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
    @JoinColumn(name = "senderId", referencedColumnName = "senderId")
    private User sender;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipientId", referencedColumnName = "recipientId")
    private User recipient;
    private String text;
    private Instant createdDate;
}
