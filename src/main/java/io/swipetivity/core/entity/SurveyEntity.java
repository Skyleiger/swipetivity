package io.swipetivity.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "Survey")
@Table(name = "surveys", uniqueConstraints = {
        @UniqueConstraint(name = "unique_community_and_name", columnNames = {"community_id", "name"})
})
public class SurveyEntity extends BaseEntity {

    @ManyToOne(optional = false)
    @JoinColumn(name = "community_id", nullable = false)
    private CommunityEntity community;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", nullable = false)
    private String description;

}