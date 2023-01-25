package com.m15.Reseller.controller;

import com.m15.Reseller.dto.LikeDto;
import com.m15.Reseller.dto.WishlistDto;
import com.m15.Reseller.model.Wishlist;
import com.m15.Reseller.service.WishlistService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.ResponseEntity.status;

@RestController
@RequestMapping("/api/wishlist")
@AllArgsConstructor
public class WishlistController {
    private final WishlistService wishlistService;
    @PostMapping
    public ResponseEntity<String> wishlist(@RequestBody WishlistDto wishlistDto) {

        return status(HttpStatus.OK).body(wishlistService.savePost(wishlistDto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteWishlist(@PathVariable Long id) {
        return new ResponseEntity<>(wishlistService.deleteWishlist(id), HttpStatus.MOVED_PERMANENTLY);
    }

    @GetMapping("by-user/{username}")
    public ResponseEntity<List<WishlistDto>> getWishlistsByUsername(@PathVariable String username) {
        return status(HttpStatus.OK).body(wishlistService.getSavesByUsername(username));
    }
}
