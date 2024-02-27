package io.swipetivity.core.dto.response.user;

import io.swipetivity.core.enums.Language;
import lombok.Value;

import java.io.Serializable;

@Value
public class ViewAccountResponse implements Serializable {

    String emailAddress;
    String firstName;
    String lastName;
    String username;
    Language language;

}