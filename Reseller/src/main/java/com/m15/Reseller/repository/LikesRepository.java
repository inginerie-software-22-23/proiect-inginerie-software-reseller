package com.m15.Reseller.repository;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
@Transactional
public interface LikesRepository extends JpaRepository<Likes, Long> {
    Optional<Likes> findTopByPostAndUserOrderByLikeIdDesc(Post post, User user);

    List<Likes> findByUser(User user);
    List<Likes> findAllByPost(Post post);
}
