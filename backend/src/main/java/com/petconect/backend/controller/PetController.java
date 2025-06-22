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

@RestController
@RequestMapping("/api/pets")
@RequiredArgsConstructor
public class PetController {
    private final PetRepository petRepository;
    private final TutorRepository tutorRepository;

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
    public Pet create(@RequestBody Pet pet) {
        // Garante que o tutor existe
        Tutor tutor = tutorRepository.findById(pet.getTutor().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Tutor não encontrado"));
        pet.setTutor(tutor);
        return petRepository.save(pet);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Pet> update(@PathVariable Long id, @RequestBody Pet pet) {
        return petRepository.findById(id)
                .map(existing -> {
                    pet.setId(id);
                    return ResponseEntity.ok(petRepository.save(pet));
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