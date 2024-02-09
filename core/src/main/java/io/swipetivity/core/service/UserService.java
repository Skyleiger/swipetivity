package io.swipetivity.core.service;

import com.neovisionaries.i18n.LanguageCode;
import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;

    public UserEntity createUser(String emailAddress, String password, String firstName, String lastName, String username, LanguageCode language) {
        UserEntity user = new UserEntity();
        user.setEmailAddress(emailAddress);
        user.setPassword(passwordEncoder.encode(password));
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setUsername(username);
        user.setLanguage(language);

        return repository.save(user);
    }

    public Optional<UserEntity> findUserById(long id) {
        return repository.findById(id);
    }

    public Optional<UserEntity> findUserByEmailAddress(String emailAddress) {
        return repository.findByEmailAddress(emailAddress);
    }

    public boolean existsUserByEmailAddress(String emailAddress) {
        return repository.existsByEmailAddress(emailAddress);
    }

}