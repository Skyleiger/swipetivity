package io.swipetivity.core.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity(name = "Community")
@Table(name = "communities")
public class CommunityEntity extends BaseEntity {

    @Column(name = "pin", nullable = false, unique = true, updatable = false)
    private String pin;

    @Column(name = "name", nullable = false)
    private String name;

    @OneToMany(mappedBy = "community", orphanRemoval = true)
    private Set<CommunityMemberEntity> members = new LinkedHashSet<>();

    @OneToMany(mappedBy = "community", orphanRemoval = true)
    private Set<SurveyEntity> surveys = new LinkedHashSet<>();

    public void addMember(CommunityMemberEntity member) {
        members.add(member);
        member.setCommunity(this);
    }

    public void addMember(UserEntity user) {
        CommunityMemberEntity member = new CommunityMemberEntity();
        member.setUser(user);
        addMember(member);
    }

    public void removeMember(CommunityMemberEntity member) {
        members.remove(member);
        member.setCommunity(null);
    }

    public void removeMember(UserEntity user) {
        members.stream()
                .filter(member -> member.getUser().equals(user))
                .findFirst()
                .ifPresent(this::removeMember);
    }

    public boolean hasMember(UserEntity user) {
        return members.stream().anyMatch(member -> member.getUser().equals(user));
    }

    public void addSurvey(SurveyEntity survey) {
        surveys.add(survey);
        survey.setCommunity(this);
    }

}