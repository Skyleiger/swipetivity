package io.swipetivity.core.dto.response.community;

import lombok.Value;

import java.io.Serializable;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link io.swipetivity.core.entity.CommunityEntity}.
 */
@Value
public class CommunityResponse implements Serializable {

    long id;
    String pin;
    String name;
    List<CommunityMemberResponse> members;
    Instant createdAt;

}