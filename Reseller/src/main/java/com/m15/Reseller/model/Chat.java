package com.m15.Reseller.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import kotlin.Lazy;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

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
    @OneToOne()
    @JoinColumn(name = "firstUserId", referencedColumnName = "userId")
    private User firstUser;
    @OneToOne()
    @JoinColumn(name = "secondUserId", referencedColumnName = "userId")
    private User secondUser;
    @OneToMany(mappedBy = "chat", cascade = CascadeType.ALL)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Message> messages = new ArrayList<>();
}
