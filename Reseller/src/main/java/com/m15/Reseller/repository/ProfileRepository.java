package com.m15.Reseller.repository;

import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface ProfileRepository extends JpaRepository<Profile, Long> {
    List<Profile> findByUser(User user);
}
