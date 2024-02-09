package io.swipetivity.core.controller;

import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.dto.response.user.ViewAccountResponse;
import io.swipetivity.core.service.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/account")
@RequiredArgsConstructor
public class AccountController {

    private final AccountService accountService;

    @GetMapping
    public ViewAccountResponse viewAccount() {
        UserEntity user = accountService.getAccount();

        return new ViewAccountResponse(
                user.getEmailAddress(),
                user.getFirstName(),
                user.getLastName(),
                user.getUsername(),
                user.getLanguage()
        );
    }

}