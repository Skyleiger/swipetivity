package io.swipetivity.core.service;

import io.swipetivity.core.configuration.TokenAuthentication;
import io.swipetivity.core.entity.AuthTokenEntity;
import io.swipetivity.core.repository.AuthTokenRepository;
import io.swipetivity.core.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final AuthTokenRepository authTokenRepository;
    private final PasswordEncoder passwordEncoder;

    public Optional<String> createToken(String emailAddress, String password) {
        Optional<UserEntity> user = userService.findUserByEmailAddress(emailAddress);
        if (user.isEmpty()) {
            return Optional.empty();
        }

        if (!passwordEncoder.matches(password, user.get().getPassword())) {
            return Optional.empty();
        }

        String token = RandomStringUtils.random(64);

        AuthTokenEntity authToken = new AuthTokenEntity();
        authToken.setUser(user.get());
        authToken.setToken(token);

        authTokenRepository.save(authToken);

        return Optional.of(token);
    }

    public Optional<UserEntity> validateToken(String token) {
        if (token == null) {
            return Optional.empty();
        }

        return authTokenRepository.findByToken(token)
                .map(AuthTokenEntity::getUser);
    }

    public void deleteToken(String token) {
        authTokenRepository.deleteByToken(token);
    }

    public TokenAuthentication getCurrentAuthentication() {
        return (TokenAuthentication) SecurityContextHolder.getContext().getAuthentication();
    }

    public long getCurrentUserId() {
        return getCurrentAuthentication().getPrincipal();
    }

    public UserEntity getCurrentUser() {
        return userService.findUserById(getCurrentUserId()).orElseThrow();
    }

    public boolean isAuthenticated() {
        return SecurityContextHolder.getContext().getAuthentication().isAuthenticated();
    }

}