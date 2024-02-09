package io.swipetivity.core.entity;

import com.neovisionaries.i18n.LanguageCode;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity(name = "User")
@Table(name = "users")
public class UserEntity extends BaseEntity {

    @Column(name = "email_address", unique = true, nullable = false)
    private String emailAddress;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "language", nullable = false)
    @Enumerated(EnumType.STRING)
    private LanguageCode language = LanguageCode.en;

    @OneToMany(mappedBy = "user", orphanRemoval = true)
    private Set<AuthTokenEntity> authenticationTokens = new LinkedHashSet<>();

    @OneToMany
    @JoinTable(
            name = "community_members",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "community_id")
    )
    private Set<CommunityEntity> communities = new LinkedHashSet<>();

}