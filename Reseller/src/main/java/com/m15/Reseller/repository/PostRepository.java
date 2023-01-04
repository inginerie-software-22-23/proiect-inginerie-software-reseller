package com.m15.Reseller.repository;

import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {
    List<Post> findByUser(User user);
}
