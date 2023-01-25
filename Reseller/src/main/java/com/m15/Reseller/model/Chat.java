package com.m15.Reseller.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import kotlin.Lazy;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Entity
@Builder
public class Chat {
    @Transient
    public static final String SEQUENCE_NAME = "chat_sequence";
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long chatId;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "firstUserId", referencedColumnName = "userId")
    private User firstUser;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "secondUserId", referencedColumnName = "userId")
    private User secondUser;
    @OneToMany(mappedBy = "chat", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Message> messages = new ArrayList<>();
}
