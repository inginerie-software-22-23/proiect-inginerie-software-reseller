package com.m15.Reseller.repository;

import com.m15.Reseller.model.Comment;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Transactional
public interface CommentRepository extends JpaRepository<Comment, Long> {
     List<Comment> findByUser(User user);
     List<Comment> findByPost(Post post);
}
