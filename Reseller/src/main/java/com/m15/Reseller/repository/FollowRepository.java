package com.m15.Reseller.repository;

import com.m15.Reseller.model.Follow;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
@Transactional
public interface FollowRepository extends JpaRepository<Follow, Long> {
    Optional<Follow> findByFollowerAndFollowed(User follower, User followed);
    List<Follow> findAllByFollower(User follower);
    List<Follow> findAllByFollowed(User followed);
}
