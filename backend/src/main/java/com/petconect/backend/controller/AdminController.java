package com.petconect.backend.controller;

import com.petconect.backend.model.*;
import com.petconect.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminRepository adminRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final VetServiceRepository vetServiceRepository;
    private final PetRepository petRepository;
    private final FoodRepository foodRepository;
    private final StoreRepository storeRepository;

    // ===== GERENCIAMENTO DE USUÁRIOS =====
    
    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return userRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @PutMapping("/users/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User userDetails) {
        return userRepository.findById(id).map(user -> {
            user.setName(userDetails.getName());
            user.setEmail(userDetails.getEmail());
            user.setPhone(userDetails.getPhone());
            
            // A anotação @Transactional garante que a sessão do Hibernate permaneça
            // aberta, permitindo o downcasting e a atualização correta das subclasses.
            if (user instanceof Veterinario) {
                 // O frontend não envia o CRMV, então não há o que atualizar aqui por enquanto.
                 // Poderíamos adicionar esse campo ao formulário de edição do admin no futuro.
            } else if (user instanceof Lojista) {
                 // O mesmo para CNPJ.
            }
            
            User updatedUser = userRepository.save(user);
            return ResponseEntity.ok(updatedUser);
        }).orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        return userRepository.findById(id).map(user -> {
            // Se o usuário for um tutor, precisamos dissociar os pets antes de deletar.
            if (user instanceof Tutor) {
                Tutor tutor = (Tutor) user;
                List<Pet> pets = petRepository.findByTutor(tutor);
                for (Pet pet : pets) {
                    pet.setTutor(null); // Ou reatribuir a um tutor "órfão", se existir
                    petRepository.save(pet);
                }
            }
            userRepository.deleteById(id);
            return ResponseEntity.noContent().<Void>build();
        }).orElse(ResponseEntity.notFound().build());
    }

    // ===== GERENCIAMENTO DE PRODUTOS =====
    
    @GetMapping("/products")
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @GetMapping("/products/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable Long id) {
        return productRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @PutMapping("/products/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product productDetails) {
        return productRepository.findById(id).map(product -> {
            product.setName(productDetails.getName());
            product.setDescription(productDetails.getDescription());
            product.setPrice(productDetails.getPrice());
            Product updatedProduct = productRepository.save(product);
            return ResponseEntity.ok(updatedProduct);
        }).orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @DeleteMapping("/products/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        if (productRepository.existsById(id)) {
            productRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    // ===== GERENCIAMENTO DE SERVIÇOS VETERINÁRIOS =====
    
    @GetMapping("/services")
    public List<VetService> getAllServices() {
        return vetServiceRepository.findAll();
    }

    @GetMapping("/services/{id}")
    public ResponseEntity<VetService> getServiceById(@PathVariable Long id) {
        return vetServiceRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @PutMapping("/services/{id}")
    public ResponseEntity<VetService> updateService(@PathVariable Long id, @RequestBody VetService serviceDetails) {
        return vetServiceRepository.findById(id).map(service -> {
            service.setName(serviceDetails.getName());
            service.setDescription(serviceDetails.getDescription());
            service.setPrice(serviceDetails.getPrice());
            VetService updatedService = vetServiceRepository.save(service);
            return ResponseEntity.ok(updatedService);
        }).orElse(ResponseEntity.notFound().build());
    }

    @Transactional
    @DeleteMapping("/services/{id}")
    public ResponseEntity<Void> deleteService(@PathVariable Long id) {
        if (vetServiceRepository.existsById(id)) {
            vetServiceRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    // ===== GERENCIAMENTO DE PETS =====
    
    @GetMapping("/pets")
    public List<Pet> getAllPets() {
        return petRepository.findAll();
    }

    @GetMapping("/pets/{id}")
    public ResponseEntity<Pet> getPetById(@PathVariable Long id) {
        return petRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/pets/{id}")
    public ResponseEntity<Pet> updatePet(@PathVariable Long id, @RequestBody Pet pet) {
        return petRepository.findById(id)
                .map(existing -> {
                    pet.setId(id);
                    return ResponseEntity.ok(petRepository.save(pet));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/pets/{id}")
    public ResponseEntity<Void> deletePet(@PathVariable Long id) {
        if (petRepository.existsById(id)) {
            petRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    // ===== GERENCIAMENTO DE ALIMENTOS =====
    
    @GetMapping("/foods")
    public List<Food> getAllFoods() {
        return foodRepository.findAll();
    }

    @GetMapping("/foods/{id}")
    public ResponseEntity<Food> getFoodById(@PathVariable Long id) {
        return foodRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/foods/{id}")
    public ResponseEntity<Food> updateFood(@PathVariable Long id, @RequestBody Food food) {
        return foodRepository.findById(id)
                .map(existing -> {
                    food.setId(id);
                    return ResponseEntity.ok(foodRepository.save(food));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/foods/{id}")
    public ResponseEntity<Void> deleteFood(@PathVariable Long id) {
        if (foodRepository.existsById(id)) {
            foodRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    // ===== GERENCIAMENTO DE LOJAS =====
    
    @GetMapping("/stores")
    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }

    @GetMapping("/stores/{id}")
    public ResponseEntity<Store> getStoreById(@PathVariable Long id) {
        return storeRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/stores/{id}")
    public ResponseEntity<Store> updateStore(@PathVariable Long id, @RequestBody Store store) {
        return storeRepository.findById(id)
                .map(existing -> {
                    store.setId(id);
                    return ResponseEntity.ok(storeRepository.save(store));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/stores/{id}")
    public ResponseEntity<Void> deleteStore(@PathVariable Long id) {
        if (storeRepository.existsById(id)) {
            storeRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    // ===== ESTATÍSTICAS DO SISTEMA =====
    
    @GetMapping("/stats")
    public ResponseEntity<SystemStats> getSystemStats() {
        long totalUsers = userRepository.count();
        long totalProducts = productRepository.count();
        long totalServices = vetServiceRepository.count();
        long totalPets = petRepository.count();
        long totalFoods = foodRepository.count();
        long totalStores = storeRepository.count();
        
        SystemStats stats = new SystemStats(totalUsers, totalProducts, totalServices, totalPets, totalFoods, totalStores);
        return ResponseEntity.ok(stats);
    }

    // Classe interna para estatísticas
    public static class SystemStats {
        private final long totalUsers;
        private final long totalProducts;
        private final long totalServices;
        private final long totalPets;
        private final long totalFoods;
        private final long totalStores;

        public SystemStats(long totalUsers, long totalProducts, long totalServices, long totalPets, long totalFoods, long totalStores) {
            this.totalUsers = totalUsers;
            this.totalProducts = totalProducts;
            this.totalServices = totalServices;
            this.totalPets = totalPets;
            this.totalFoods = totalFoods;
            this.totalStores = totalStores;
        }

        // Getters
        public long getTotalUsers() { return totalUsers; }
        public long getTotalProducts() { return totalProducts; }
        public long getTotalServices() { return totalServices; }
        public long getTotalPets() { return totalPets; }
        public long getTotalFoods() { return totalFoods; }
        public long getTotalStores() { return totalStores; }
    }
} 