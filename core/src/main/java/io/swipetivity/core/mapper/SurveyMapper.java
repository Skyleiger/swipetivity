package io.swipetivity.core.mapper;

import io.swipetivity.core.dto.response.survey.SurveyResponse;
import io.swipetivity.core.entity.SurveyEntity;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING, uses = {CommunityMapper.class})
public interface SurveyMapper {
    SurveyEntity toEntity(SurveyResponse surveyResponse);

    SurveyResponse toDTO(SurveyEntity surveyEntity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    SurveyEntity partialUpdate(SurveyResponse surveyResponse, @MappingTarget SurveyEntity surveyEntity);

}