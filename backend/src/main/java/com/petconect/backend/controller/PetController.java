package com.petconect.backend.controller;

import com.petconect.backend.model.Pet;
import com.petconect.backend.model.Tutor;
import com.petconect.backend.repository.PetRepository;
import com.petconect.backend.repository.TutorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/pets")
@RequiredArgsConstructor
public class PetController {
    private final PetRepository petRepository;
    private final TutorRepository tutorRepository;
    private static final Logger logger = LoggerFactory.getLogger(PetController.class);

    @GetMapping
    public List<Pet> getByTutor(@RequestParam(required = false) Long tutorId) {
        if (tutorId != null) {
            return petRepository.findByTutorId(tutorId);
        }
        return petRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pet> getById(@PathVariable Long id) {
        return petRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Pet> create(@RequestBody Map<String, Object> payload) {
        logger.info("Recebido payload para criar pet: {}", payload);
        try {
            Pet pet = new Pet();
            pet.setName((String) payload.get("name"));
            pet.setType((String) payload.get("type"));
            pet.setBreed((String) payload.get("breed"));
            pet.setAge((Integer) payload.get("age"));
            pet.setWeight(((Number) payload.get("weight")).doubleValue());
            pet.setPhotoUrl((String) payload.get("photoUrl"));
            pet.setActivityLevel((String) payload.get("activityLevel"));

            Integer tutorId = (Integer) payload.get("tutorId");
            if (tutorId == null) {
                 throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "tutorId é obrigatório");
            }

            Tutor tutor = tutorRepository.findById(tutorId.longValue())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Tutor não encontrado com ID: " + tutorId));
        pet.setTutor(tutor);

            Pet savedPet = petRepository.save(pet);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedPet);
        } catch (Exception e) {
            logger.error("Erro ao criar pet: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Pet> update(@PathVariable Long id, @RequestBody Map<String, Object> payload) {
        logger.info("Recebido payload para atualizar pet {}: {}", id, payload);
        return petRepository.findById(id)
            .map(existingPet -> {
                if (payload.containsKey("name")) existingPet.setName((String) payload.get("name"));
                if (payload.containsKey("breed")) existingPet.setBreed((String) payload.get("breed"));
                if (payload.containsKey("age")) existingPet.setAge((Integer) payload.get("age"));
                if (payload.containsKey("weight")) existingPet.setWeight(((Number) payload.get("weight")).doubleValue());
                if (payload.containsKey("photoUrl")) existingPet.setPhotoUrl((String) payload.get("photoUrl"));
                if (payload.containsKey("type")) existingPet.setType((String) payload.get("type"));
                if (payload.containsKey("activityLevel")) existingPet.setActivityLevel((String) payload.get("activityLevel"));

                if (payload.containsKey("tutorId")) {
                    Integer tutorId = (Integer) payload.get("tutorId");
                    Tutor tutor = tutorRepository.findById(tutorId.longValue())
                            .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Tutor não encontrado com ID: " + tutorId));
                    existingPet.setTutor(tutor);
                }
                
                Pet updatedPet = petRepository.save(existingPet);
                return ResponseEntity.ok(updatedPet);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (petRepository.existsById(id)) {
            petRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
} 