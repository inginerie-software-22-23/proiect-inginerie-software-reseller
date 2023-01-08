package com.m15.Reseller.repository;

import com.m15.Reseller.model.Comment;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
     List<Comment> findByUser(User user);
     List<Comment> findByPost(Post post);
}
