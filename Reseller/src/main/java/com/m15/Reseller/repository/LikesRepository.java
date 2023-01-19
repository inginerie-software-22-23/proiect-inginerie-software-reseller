package com.m15.Reseller.repository;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LikesRepository extends JpaRepository<Likes, Long> {
    Optional<Likes> findTopByPostAndUserOrderByLikeIdDesc(Post post, User user);

    List<Likes> findByUser(User user);
}
