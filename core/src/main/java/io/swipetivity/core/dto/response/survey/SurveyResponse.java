package io.swipetivity.core.dto.response.survey;

import io.swipetivity.core.dto.response.community.CommunityResponse;
import lombok.Value;

import java.io.Serializable;
import java.time.Instant;

/**
 * DTO for {@link io.swipetivity.core.entity.SurveyEntity}
 */
@Value
public class SurveyResponse implements Serializable {

    long id;
    Instant createdAt;
    CommunityResponse community;
    String name;
    String description;

}