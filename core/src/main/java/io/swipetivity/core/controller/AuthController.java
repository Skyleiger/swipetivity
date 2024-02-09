package io.swipetivity.core.controller;

import io.swipetivity.core.dto.request.LoginRequest;
import io.swipetivity.core.dto.request.RegisterRequest;
import io.swipetivity.core.dto.response.auth.LoginResponse;
import io.swipetivity.core.service.AuthService;
import io.swipetivity.core.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final UserService userService;

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest request) {
        Optional<String> token = authService.createToken(request.getEmail(), request.getPassword());

        if (token.isEmpty()) {
            throw new BadCredentialsException("Invalid credentials provided");
        }

        return new LoginResponse(token.get());
    }

    @PostMapping("/logout")
    public void logout() {
        authService.deleteToken(authService.getCurrentAuthentication().getCredentials());
    }

    @PostMapping("/register")
    public void register(@RequestBody RegisterRequest request) {
        if (userService.existsUserByEmailAddress(request.getEmailAddress())) {
            throw new IllegalArgumentException("User with email address %s already exists.".formatted(request.getEmailAddress()));
        }

        userService.createUser(
                request.getEmailAddress(),
                request.getPassword(),
                request.getFirstName(),
                request.getLastName(),
                request.getUsername(),
                request.getLanguage()
        );
    }

}