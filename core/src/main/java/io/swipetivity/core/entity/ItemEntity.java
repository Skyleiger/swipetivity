package io.swipetivity.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity(name = "Item")
@Table(name = "items")
public class ItemEntity extends BaseEntity {

    @ManyToOne(optional = false)
    @JoinColumn(name = "type_id", nullable = false)
    private ItemTypeEntity type;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", nullable = false)
    private String description;

    @ManyToMany(mappedBy = "items")
    private Set<ItemCategoryEntity> categories = new LinkedHashSet<>();


}