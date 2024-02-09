package io.swipetivity.core.service;

import io.swipetivity.core.entity.CommunityEntity;
import io.swipetivity.core.entity.UserEntity;
import io.swipetivity.core.repository.CommunityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CommunityService {

    private final AuthService authService;
    private final CommunityRepository repository;

    public List<CommunityEntity> fetchCommunities(UserEntity user) {
        return repository.findByMembers_User(user);
    }

    public Optional<CommunityEntity> findCommunityById(long id) {
        return repository.findById(id);
    }

    public Optional<CommunityEntity> findCommunityByPin(String pin) {
        return repository.findByPin(pin);
    }

    public void joinCommunity(CommunityEntity community, UserEntity user) {
        if (community.hasMember(user)) {
            throw new IllegalStateException("User %s is already a member of community %s.".formatted(user.getId(), community.getId()));
        }

        community.addMember(user);
        repository.save(community);
    }

    public void leaveCommunity(CommunityEntity community, UserEntity user) {
        if (!community.hasMember(user)) {
            throw new IllegalStateException("User %s is not a member of community %s.".formatted(user.getId(), community.getId()));
        }

        community.removeMember(user);
        repository.save(community);
    }

}