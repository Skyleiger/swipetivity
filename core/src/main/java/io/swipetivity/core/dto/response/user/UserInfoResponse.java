package io.swipetivity.core.dto.response.user;

import lombok.Value;

import java.io.Serializable;

@Value
public class UserInfoResponse implements Serializable {

    long id;
    String username;

}