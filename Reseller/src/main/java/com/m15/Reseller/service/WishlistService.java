package com.m15.Reseller.service;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.dto.WishlistDto;
import com.m15.Reseller.dto.exception.PostNotFoundException;
import com.m15.Reseller.dto.exception.SpringResellerException;
import com.m15.Reseller.model.Likes;
import com.m15.Reseller.model.Post;
import com.m15.Reseller.model.User;
import com.m15.Reseller.model.Wishlist;
import com.m15.Reseller.repository.LikesRepository;
import com.m15.Reseller.repository.PostRepository;
import com.m15.Reseller.repository.UserRepository;
import com.m15.Reseller.repository.WishlistRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
@Transactional
public class WishlistService {
    private final PostRepository postRepository;
    private final WishlistRepository wishlistRepository;
    private final UserRepository userRepository;
    private final AuthService authService;
    public String savePost(WishlistDto wishlistDto) {
        Post post = postRepository.findById(wishlistDto.getPostId())
                .orElseThrow(() -> new PostNotFoundException("Post with id " + wishlistDto.getPostId() + " not found!"));

        Optional<Wishlist> wishlistByPostAndUser = wishlistRepository.findTopByPostAndUserOrderByWishlistIdDesc(post, authService.getCurrentUser());

        if (wishlistByPostAndUser.isPresent()) {
            throw new SpringResellerException("You have already saved this post!");
        }

        post.setSavedCount(post.getSavedCount() + 1);
        wishlistRepository.save(mapToWishlist(wishlistDto, post));
        postRepository.save(post);
        return "Success";
    }



    public List<WishlistDto> getSavesByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found!"));
        return wishlistRepository.findByUser(user)
                .stream()
                .map(this::mapToDto)
                .toList();
    }

    private Wishlist mapToWishlist(WishlistDto wishlistDto, Post post) {
        return Wishlist.builder()
                .post(post)
                .user(authService.getCurrentUser())
                .build();
    }

    private WishlistDto mapToDto(Wishlist wishlist) {
        WishlistDto dto = new WishlistDto();
        dto.setPostId(wishlist.getPost().getPostId());
        return dto;
    }

    public String deleteWishlist(Long id) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new PostNotFoundException("Post with id " + id + " not found!"));

        Optional<Wishlist> wishlistByPostAndUser = wishlistRepository.findTopByPostAndUserOrderByWishlistIdDesc(post, authService.getCurrentUser());

        if (wishlistByPostAndUser.isEmpty()) {
            throw new SpringResellerException("You didn't save this post yet!");
        }

        wishlistRepository.deleteById(wishlistByPostAndUser.get().getWishlistId());
        post.setSavedCount(post.getSavedCount() - 1);
        return "Deleted";
    }
}
