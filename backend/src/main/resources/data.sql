-- Dados iniciais para o sistema PetConnect
-- Este script será executado automaticamente pelo Spring Boot

-- Inserir usuários de teste na tabela base 'users' com senhas codificadas com BCrypt
-- Senha para todos os usuários de teste é "admin123" (codificada com BCrypt)
INSERT INTO users (id, dtype, name, email, password, phone, location, created_at, updated_at, crmv, cnpj, responsible_name, operating_hours, store_type) VALUES
-- Tutor (ID 1)
(1, 'TUTOR', 'João Silva', 'tutor@teste.com', '$2a$10$Hg4ril7fJL2.GRTXLmwGwOqeMmaDL2Wjn4xbCGXsZkbvv9OvCkmAW', '(11) 99999-9999', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, NULL, NULL, NULL, NULL),
-- Veterinario (ID 2)
(2, 'VETERINARIO', 'Dr. Maria Santos', 'vet@teste.com', '$2a$10$Hg4ril7fJL2.GRTXLmwGwOqeMmaDL2Wjn4xbCGXsZkbvv9OvCkmAW', '(11) 88888-8888', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'CRMV-SP 12345', NULL, NULL, NULL, NULL),
-- Lojista (ID 3)
(3, 'LOJISTA', 'PetShop Central', 'lojista@teste.com', '$2a$10$Hg4ril7fJL2.GRTXLmwGwOqeMmaDL2Wjn4xbCGXsZkbvv9OvCkmAW', '(11) 77777-7777', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, '00.000.000/0001-00', 'João da Silva', 'Segunda a Sexta, 8h às 18h', 'Petshop'),
-- Admin (ID 4)
(4, 'ADMIN', 'Administrador', 'admin@teste.com', '$2a$10$Hg4ril7fJL2.GRTXLmwGwOqeMmaDL2Wjn4xbCGXsZkbvv9OvCkmAW', '(11) 66666-6666', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, NULL, NULL, NULL, NULL);

-- Inserir pets de teste (associados ao Tutor ID 1)
INSERT INTO pet (name, type, weight, age, activity_level, breed, notes, tutor_id, photo_url) VALUES
('Rex', 'Cachorro', 15.5, 3, 'Alto', 'Golden Retriever', 'Muito brincalhão', 1, 'https://images.unsplash.com/photo-1558788353-f76d92427f16?auto=format&fit=facearea&w=256&h=256&facepad=2&q=80'),
('Luna', 'Gato', 4.2, 2, 'Médio', 'Siamês', 'Muito carinhosa', 1, 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?auto=format&fit=facearea&w=256&h=256&facepad=2&q=80');

-- Inserir produtos de teste (associados ao Lojista ID 3)
INSERT INTO product (name, description, price, image_url, measurement_unit, owner_id, owner_name, owner_location, owner_phone) VALUES
('Ração Premium', 'Ração de alta qualidade para cães adultos', 89.90, 'https://example.com/racao.jpg', 'kg', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777'),
('Brinquedo Interativo', 'Brinquedo para estimular a mente do pet', 45.90, 'https://example.com/brinquedo.jpg', 'unidade', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777');

-- Inserir serviços veterinários de teste (associados ao Veterinario ID 2)
INSERT INTO vet_service (name, description, price, owner_id, owner_name, owner_location, owner_phone, owner_crmv, operating_hours) VALUES
('Consulta Veterinária', 'Consulta completa com exame físico', 150.00, 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h'),
('Vacinação', 'Aplicação de vacinas essenciais', 80.00, 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h'); 