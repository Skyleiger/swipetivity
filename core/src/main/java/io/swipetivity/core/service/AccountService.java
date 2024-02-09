package io.swipetivity.core.service;

import io.swipetivity.core.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AuthService authService;

    public UserEntity getAccount() {
        return authService.getCurrentUser();
    }

}