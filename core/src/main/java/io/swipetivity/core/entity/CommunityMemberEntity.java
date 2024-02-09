package io.swipetivity.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity(name = "CommunityMember")
@Table(name = "community_members", uniqueConstraints = {
        @UniqueConstraint(name = "unique_community_and_user", columnNames = {"community_id", "user_id"})
})
public class CommunityMemberEntity extends BaseEntity {

    @ManyToOne(optional = false)
    @JoinColumn(name = "community_id", nullable = false)
    private CommunityEntity community;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @Column(name = "joined_at", nullable = false, updatable = false)
    private Instant joinedAt = Instant.now();

}