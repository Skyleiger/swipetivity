package io.swipetivity.core.mapper;

import io.swipetivity.core.dto.response.community.CommunityResponse;
import io.swipetivity.core.entity.CommunityEntity;
import org.mapstruct.*;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING, collectionMappingStrategy = CollectionMappingStrategy.ADDER_PREFERRED)
public interface CommunityMapper {

    CommunityEntity toEntity(CommunityResponse communityResponse);

    CommunityResponse toDTO(CommunityEntity communityEntity);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    CommunityEntity partialUpdate(CommunityResponse communityResponse, @MappingTarget CommunityEntity communityEntity);

}