package com.m15.Reseller.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

import static jakarta.persistence.FetchType.LAZY;
import static jakarta.persistence.GenerationType.IDENTITY;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Comment {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long commentId;
    @NotEmpty
    private String text;
    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "postId", referencedColumnName = "postId")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Post post;
    private Instant createdDate;
    @ManyToOne(fetch = LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;
}
