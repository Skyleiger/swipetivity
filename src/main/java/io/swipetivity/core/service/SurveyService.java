package io.swipetivity.core.service;

import io.swipetivity.core.entity.CommunityEntity;
import io.swipetivity.core.entity.SurveyEntity;
import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.repository.SurveyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class SurveyService {

    private final SurveyRepository repository;

    public List<SurveyEntity> fetchSurveys(UserEntity user) {
        return repository.findAllByCommunity_Members_User(user);
    }

    public List<SurveyEntity> fetchSurveys(CommunityEntity community) {
        return repository.findAllByCommunity(community);
    }

    public Optional<SurveyEntity> findSurveyById(long id) {
        return repository.findById(id);
    }

    public SurveyEntity createSurvey(CommunityEntity community, String name, String description) {
        SurveyEntity survey = new SurveyEntity();
        survey.setName(name);
        survey.setCommunity(community);
        survey.setDescription(description);
        return repository.save(survey);
    }

}