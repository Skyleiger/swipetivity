package io.swipetivity.core.repository;

import io.swipetivity.core.entity.CommunityEntity;
import io.swipetivity.core.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;
import java.util.Optional;

public interface CommunityRepository extends PagingAndSortingRepository<CommunityEntity, Long>, JpaRepository<CommunityEntity, Long> {

    List<CommunityEntity> findByMembers_User(UserEntity user);

    Optional<CommunityEntity> findByPin(String pin);

}