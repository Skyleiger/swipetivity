package io.swipetivity.core.dto.response.user;

import com.neovisionaries.i18n.LanguageCode;
import lombok.Value;

import java.io.Serializable;

@Value
public class ViewAccountResponse implements Serializable {

    String emailAddress;
    String firstName;
    String lastName;
    String username;
    LanguageCode language;

}