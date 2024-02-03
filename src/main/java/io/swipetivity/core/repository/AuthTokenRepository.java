package io.swipetivity.core.repository;

import io.swipetivity.core.entity.AuthTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AuthTokenRepository extends JpaRepository<AuthTokenEntity, Long> {

    Optional<AuthTokenEntity> findByToken(String token);

    void deleteByToken(String token);

}