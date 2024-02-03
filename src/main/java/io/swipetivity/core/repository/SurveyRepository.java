package io.swipetivity.core.repository;

import io.swipetivity.core.entity.CommunityEntity;
import io.swipetivity.core.entity.SurveyEntity;
import io.swipetivity.core.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

public interface SurveyRepository extends PagingAndSortingRepository<SurveyEntity, Long>, JpaRepository<SurveyEntity, Long> {

    List<SurveyEntity> findAllByCommunity_Members_User(UserEntity user);

    List<SurveyEntity> findAllByCommunity(CommunityEntity community);

}