package com.petconect.backend.repository;

import com.petconect.backend.model.Pet;
import com.petconect.backend.model.Tutor;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PetRepository extends JpaRepository<Pet, Long> {
    List<Pet> findByTutorId(Long tutorId);
    List<Pet> findByTutor(Tutor tutor);
} 