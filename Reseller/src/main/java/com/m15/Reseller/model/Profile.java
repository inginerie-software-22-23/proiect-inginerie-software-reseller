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
public class Profile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long profileId;
    private String username;
    private String fullName;
    private String description;
    private String imageUrl;
    private boolean isActive;
    @OneToOne(fetch = LAZY)
    private User user;
}
