package io.swipetivity.core.configuration;

import io.swipetivity.core.service.AuthService;
import io.swipetivity.core.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import java.util.Optional;

@RequiredArgsConstructor
@Component
public class TokenAuthenticationProvider implements AuthenticationProvider {

    private final AuthService authService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        if (!(authentication instanceof TokenAuthentication tokenAuthentication)) {
            throw new IllegalArgumentException("Not a TokenAuthentication");
        }

        Optional<UserEntity> user = authService.validateToken(tokenAuthentication.getCredentials());

        if (user.isEmpty()) {
            throw new BadCredentialsException("Invalid token");
        }

        return new TokenAuthentication(tokenAuthentication.getCredentials(), user.get().getId());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return TokenAuthentication.class.isAssignableFrom(authentication);
    }

}