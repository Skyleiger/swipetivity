package io.swipetivity.core.dto.response.community;

import io.swipetivity.core.dto.response.user.UserInfoResponse;
import lombok.Value;

import java.io.Serializable;
import java.time.Instant;

@Value
public class CommunityMemberResponse implements Serializable {

    UserInfoResponse user;
    Instant joinedAt;

}