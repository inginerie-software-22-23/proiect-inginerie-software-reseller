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
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long messageId;
    @OneToOne(fetch = LAZY)
    private User receiver;
    @OneToOne(fetch = LAZY)
    private User sender;
    private String text;
    private MessageStatus status;
}
