package com.m15.Reseller.repository;

import com.m15.Reseller.model.Profile;
import com.m15.Reseller.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
@Repository
@Transactional
public interface ProfileRepository extends JpaRepository<Profile, Long> {
    Profile findByUser(User user);
    List<Profile> findByUsernameStartingWith(String username);

}
