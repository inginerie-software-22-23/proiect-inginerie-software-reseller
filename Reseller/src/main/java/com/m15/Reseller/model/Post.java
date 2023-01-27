package com.m15.Reseller.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Entity
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long postId;
    private String imageUrl = "";
    @NotBlank(message = "Community name is required")
    private String title;
    private String description;
    private Integer price;
    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private User user;
    private Instant createdDate;
    private Integer likesCount = 0;
    private Integer savedCount = 0;
    private Integer commentCount = 0;
}
