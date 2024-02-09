package io.swipetivity.core.configuration;

import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.security.authentication.AbstractAuthenticationToken;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class TokenAuthentication extends AbstractAuthenticationToken {

    private final String token;
    private final Long userId;

    public TokenAuthentication(String token) {
        this(token, null);
    }

    public TokenAuthentication(String token, Long userId) {
        super(List.of());
        this.token = token;
        this.userId = userId;
        setAuthenticated(userId != null);
    }

    @Override
    public String getCredentials() {
        return token;
    }

    @Override
    public Long getPrincipal() {
        return userId;
    }

}