package com.m15.Reseller.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDateTime;

import static jakarta.persistence.FetchType.LAZY;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Entity
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long notificationId;
    private String text;
    private boolean flag;
    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "sender_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User sender;
    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "recipient_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User recipient;
    @ManyToOne
    @JoinColumn(name = "post_id", nullable = true)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Post interactionPost;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private NotificationType type;
    @Column(nullable = false)
    private LocalDateTime timestamp;
}
