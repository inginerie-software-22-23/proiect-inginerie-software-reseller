package com.m15.Reseller.model;

import jakarta.persistence.*;
import lombok.*;

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
    private boolean ispost;
    @ManyToOne(fetch = LAZY)
    private User sender;
    @ManyToOne(fetch = LAZY)
    private User recipient;
    @ManyToOne
    private Post post;
}



