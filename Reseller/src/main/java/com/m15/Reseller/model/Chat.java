package com.m15.Reseller.model;

import jakarta.persistence.*;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Entity
@Builder
public class Chat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long chatId;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "firstUserId", referencedColumnName = "firstUserId")
    private User firstUser;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "secondUserId", referencedColumnName = "secondUserId")
    private User secondUser;
}
