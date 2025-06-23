package com.petconect.backend.controller;

import com.petconect.backend.config.JwtUtil;
import com.petconect.backend.model.User;
import com.petconect.backend.model.Tutor;
import com.petconect.backend.model.Lojista;
import com.petconect.backend.model.Veterinario;
import com.petconect.backend.repository.UserRepository;
import com.petconect.backend.repository.TutorRepository;
import com.petconect.backend.repository.LojistaRepository;
import com.petconect.backend.repository.VeterinarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;
    private final TutorRepository tutorRepository;
    private final LojistaRepository lojistaRepository;
    private final VeterinarioRepository veterinarioRepository;
    private final PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody LoginRequest loginRequest) throws Exception {
        try {
            authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
            );
        } catch (Exception e) {
            throw new Exception("Incorrect username or password", e);
        }

        final UserDetails userDetails = userDetailsService.loadUserByUsername(loginRequest.getEmail());
        final User user = userRepository.findByEmail(loginRequest.getEmail()).orElseThrow();
        final String jwt = jwtUtil.generateToken(userDetails);

        return ResponseEntity.ok(Map.of("token", jwt, "user", user));
    }

    @PostMapping("/register-tutor")
    public Tutor registerTutor(@RequestBody Tutor tutor) {
        tutor.setPassword(passwordEncoder.encode(tutor.getPassword()));
        return tutorRepository.save(tutor);
    }

    @PostMapping("/register-lojista")
    public Lojista registerLojista(@RequestBody Lojista lojista) {
        lojista.setPassword(passwordEncoder.encode(lojista.getPassword()));
        return lojistaRepository.save(lojista);
    }

    @PostMapping("/register-veterinario")
    public Veterinario registerVeterinario(@RequestBody Veterinario veterinario) {
        veterinario.setPassword(passwordEncoder.encode(veterinario.getPassword()));
        return veterinarioRepository.save(veterinario);
    }

    public static class LoginRequest {
        private String email;
        private String password;
        
        // Getters e Setters
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    @GetMapping("/validate")
    public ResponseEntity<?> validateToken(@RequestHeader(value = "Authorization", required = false) String authHeader) {
        try {
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                String token = authHeader.substring(7);
                String email = jwtUtil.getUsernameFromToken(token);
                
                if (email != null) {
                    UserDetails userDetails = userDetailsService.loadUserByUsername(email);
                    if (jwtUtil.validateToken(token, userDetails)) {
                        return ResponseEntity.ok(Map.of("valid", true, "message", "Token válido"));
                    }
                }
            }
            return ResponseEntity.status(401).body(Map.of("valid", false, "message", "Token inválido"));
        } catch (Exception e) {
            return ResponseEntity.status(401).body(Map.of("valid", false, "message", "Token inválido"));
        }
    }
} 