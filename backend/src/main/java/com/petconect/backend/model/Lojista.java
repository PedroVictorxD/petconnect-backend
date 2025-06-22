package com.petconect.backend.model;

import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.DiscriminatorValue;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@DiscriminatorValue("LOJISTA")
@Getter
@Setter
@NoArgsConstructor
public class Lojista extends User {
    private String cnpj;
    private String responsibleName;
    private String storeType;
    private String operatingHours;
} 