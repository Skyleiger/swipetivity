package io.swipetivity.core.dto.response.auth;

import lombok.Value;

import java.io.Serializable;

@Value
public class LoginResponse implements Serializable {

    String token;

}