package com.petconect.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String type;

    private String breed;

    @Column(nullable = false)
    private int age;
    
    @Column(nullable = false)
    private double weight;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tutor_id", nullable = true)
    @JsonIgnore
    private Tutor tutor;

    private String photoUrl;
    
    @Column(name = "activity_level")
    private String activityLevel;
    
    private String notes;

    @JsonProperty("ownerId")
    public Long getOwnerId() {
        return (tutor != null) ? tutor.getId() : null;
    }

    @JsonProperty("ownerName")
    public String getOwnerName() {
        return (tutor != null) ? tutor.getName() : null;
    }

    @JsonProperty("ownerPhone")
    public String getOwnerPhone() {
        return (tutor != null) ? tutor.getPhone() : null;
    }
} 