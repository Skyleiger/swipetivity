package io.swipetivity.core.dto.request;

import com.neovisionaries.i18n.LanguageCode;
import lombok.Data;

@Data
public class RegisterRequest {

    private final String emailAddress;
    private final String password;
    private final String firstName;
    private final String lastName;
    private final String username;
    private final LanguageCode language;

}