package com.petconect.backend.controller;

import com.petconect.backend.model.*;
import com.petconect.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminRepository adminRepository;
    private final TutorRepository tutorRepository;
    private final VeterinarioRepository veterinarioRepository;
    private final LojistaRepository lojistaRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final VetServiceRepository vetServiceRepository;
    private final PetRepository petRepository;
    private final FoodRepository foodRepository;
    private final StoreRepository storeRepository;
    private final PasswordEncoder passwordEncoder;

    // ===== GERENCIAMENTO DE USUÁRIOS =====
    
    @PostMapping("/admins")
    public Admin createAdmin(@RequestBody Admin admin) {
        // Codificar a senha antes de salvar
        admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        return adminRepository.save(admin);
    }
    
    @PostMapping("/tutors")
    public Tutor createTutor(@RequestBody Tutor tutor) {
        // Codificar a senha antes de salvar
        tutor.setPassword(passwordEncoder.encode(tutor.getPassword()));
        return tutorRepository.save(tutor);
    }
    
    @PostMapping("/veterinarios")
    public Veterinario createVeterinario(@RequestBody Veterinario veterinario) {
        // Codificar a senha antes de salvar
        veterinario.setPassword(passwordEncoder.encode(veterinario.getPassword()));
        return veterinarioRepository.save(veterinario);
    }
    
    @PostMapping("/lojistas")
    public Lojista createLojista(@RequestBody Lojista lojista) {
        // Codificar a senha antes de salvar
        lojista.setPassword(passwordEncoder.encode(lojista.getPassword()));
        return lojistaRepository.save(lojista);
    }
    
    @GetMapping("/users")
    public List<User> getAllUsers() {
        List<User> allUsers = new ArrayList<>();
        allUsers.addAll(tutorRepository.findAll());
        allUsers.addAll(veterinarioRepository.findAll());
        allUsers.addAll(lojistaRepository.findAll());
        allUsers.addAll(adminRepository.findAll());
        return allUsers;
    }

    @GetMapping("/users/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        // Verificar em cada repositório específico
        User user = tutorRepository.findById(id).orElse(null);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        
        user = veterinarioRepository.findById(id).orElse(null);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        
        user = lojistaRepository.findById(id).orElse(null);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        
        user = adminRepository.findById(id).orElse(null);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        
        return ResponseEntity.notFound().build();
    }

    @Transactional
    @PutMapping("/users/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody java.util.Map<String, Object> userDetails) {
        // Primeiro, tentar encontrar o usuário em cada repositório específico
        User user = null;
        
        // Verificar se é um Tutor
        user = tutorRepository.findById(id).orElse(null);
        if (user != null) {
            Tutor tutor = (Tutor) user;
            // Atualizar campos básicos
            if (userDetails.containsKey("name")) {
                tutor.setName((String) userDetails.get("name"));
            }
            if (userDetails.containsKey("email")) {
                tutor.setEmail((String) userDetails.get("email"));
            }
            if (userDetails.containsKey("phone")) {
                tutor.setPhone((String) userDetails.get("phone"));
            }
            return ResponseEntity.ok(tutorRepository.save(tutor));
        }
        
        // Verificar se é um Veterinario
        user = veterinarioRepository.findById(id).orElse(null);
        if (user != null) {
            Veterinario veterinario = (Veterinario) user;
            // Atualizar campos básicos
            if (userDetails.containsKey("name")) {
                veterinario.setName((String) userDetails.get("name"));
            }
            if (userDetails.containsKey("email")) {
                veterinario.setEmail((String) userDetails.get("email"));
            }
            if (userDetails.containsKey("phone")) {
                veterinario.setPhone((String) userDetails.get("phone"));
            }
            // Atualizar campos específicos do veterinário
            if (userDetails.containsKey("crmv")) {
                veterinario.setCrmv((String) userDetails.get("crmv"));
            }
            return ResponseEntity.ok(veterinarioRepository.save(veterinario));
        }
        
        // Verificar se é um Lojista
        user = lojistaRepository.findById(id).orElse(null);
        if (user != null) {
            Lojista lojista = (Lojista) user;
            // Atualizar campos básicos
            if (userDetails.containsKey("name")) {
                lojista.setName((String) userDetails.get("name"));
            }
            if (userDetails.containsKey("email")) {
                lojista.setEmail((String) userDetails.get("email"));
            }
            if (userDetails.containsKey("phone")) {
                lojista.setPhone((String) userDetails.get("phone"));
            }
            // Atualizar campos específicos do lojista
            if (userDetails.containsKey("cnpj")) {
                lojista.setCnpj((String) userDetails.get("cnpj"));
            }
            if (userDetails.containsKey("responsibleName")) {
                lojista.setResponsibleName((String) userDetails.get("responsibleName"));
            }
            if (userDetails.containsKey("storeType")) {
                lojista.setStoreType((String) userDetails.get("storeType"));
            }
            if (userDetails.containsKey("operatingHours")) {
                lojista.setOperatingHours((String) userDetails.get("operatingHours"));
            }
            return ResponseEntity.ok(lojistaRepository.save(lojista));
        }
        
        // Verificar se é um Admin
        user = adminRepository.findById(id).orElse(null);
        if (user != null) {
            Admin admin = (Admin) user;
            // Atualizar campos básicos
            if (userDetails.containsKey("name")) {
                admin.setName((String) userDetails.get("name"));
            }
            if (userDetails.containsKey("email")) {
                admin.setEmail((String) userDetails.get("email"));
            }
            if (userDetails.containsKey("phone")) {
                admin.setPhone((String) userDetails.get("phone"));
            }
            return ResponseEntity.ok(adminRepository.save(admin));
        }
        
        return ResponseEntity.notFound().build();
    }

    @Transactional
    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        // Primeiro, tentar encontrar o usuário em cada repositório específico
        User user = null;
        
        // Verificar se é um Tutor
        user = tutorRepository.findById(id).orElse(null);
        if (user != null) {
            Tutor tutor = (Tutor) user;
            // Desassociar pets do tutor
            List<Pet> pets = petRepository.findByTutor(tutor);
            for (Pet pet : pets) {
                pet.setTutor(null);
                petRepository.save(pet);
            }
            tutorRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        
        // Verificar se é um Veterinario
        user = veterinarioRepository.findById(id).orElse(null);
        if (user != null) {
            Veterinario veterinario = (Veterinario) user;
            // Desassociar serviços veterinários do veterinário (usando ownerId)
            List<VetService> services = vetServiceRepository.findAll().stream()
                .filter(service -> service.getOwnerId() != null && service.getOwnerId().equals(id))
                .collect(Collectors.toList());
            for (VetService service : services) {
                service.setOwnerId(null);
                service.setOwnerName(null);
                service.setOwnerLocation(null);
                service.setOwnerPhone(null);
                service.setOwnerCrmv(null);
                vetServiceRepository.save(service);
            }
            veterinarioRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        
        // Verificar se é um Lojista
        user = lojistaRepository.findById(id).orElse(null);
        if (user != null) {
            Lojista lojista = (Lojista) user;
            // Desassociar produtos do lojista (usando ownerId)
            List<Product> products = productRepository.findAll().stream()
                .filter(product -> product.getOwnerId() != null && product.getOwnerId().equals(id))
                .collect(Collectors.toList());
            for (Product product : products) {
                product.setOwnerId(null);
                product.setOwnerName(null);
                product.setOwnerLocation(null);
                product.setOwnerPhone(null);
                productRepository.save(product);
            }
            // Desassociar lojas do lojista (usando ownerId)
            List<Store> stores = storeRepository.findAll().stream()
                .filter(store -> store.getOwnerId() != null && store.getOwnerId().equals(id))
                .collect(Collectors.toList());
            for (Store store : stores) {
                store.setOwnerId(null);
                storeRepository.save(store);
            }
            lojistaRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        
        // Verificar se é um Admin
        user = adminRepository.findById(id).orElse(null);
        if (user != null) {
            adminRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        
        return ResponseEntity.notFound().build();
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