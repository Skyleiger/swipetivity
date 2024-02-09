package io.swipetivity.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity(name = "ItemCategory")
@Table(name = "item_categories")
public class ItemCategoryEntity extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "type_id", nullable = false)
    private ItemTypeEntity type;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToMany
    @JoinTable(name = "item_category_items",
            joinColumns = @JoinColumn(name = "category_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "item_id", nullable = false))
    private Set<ItemEntity> items = new LinkedHashSet<>();

}