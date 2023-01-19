package com.m15.Reseller.repository;

import com.m15.Reseller.dto.WishlistDto;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import com.m15.Reseller.model.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    Optional<Wishlist> findTopByPostAndUserOrderByWishlistIdDesc(Post post, User currentUser);
    List<Wishlist> findByUser(User user);
}
