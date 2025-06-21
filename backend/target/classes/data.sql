-- Dados iniciais para o sistema PetConnect
-- Este script será executado automaticamente pelo Spring Boot

-- Inserir usuários de teste
INSERT INTO users (id, name, email, password, phone, location, created_at, updated_at, dtype) VALUES
(1, 'João Silva', 'joao@test.com', '123456', '(11) 99999-9999', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Tutor'),
(2, 'Dr. Maria Santos', 'maria@vet.com', '123456', '(11) 88888-8888', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Veterinario'),
(3, 'PetShop Central', 'petshop@test.com', '123456', '(11) 77777-7777', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Lojista'),
(4, 'Administrador', 'admin@petconnect.com', 'admin123', '(11) 66666-6666', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Admin');

-- Inserir dados específicos dos veterinários
INSERT INTO veterinario (id, crmv) VALUES (2, '12345-SP');

-- Inserir dados específicos dos lojistas
INSERT INTO lojista (id, cnpj, responsible_name, store_type, operating_hours) VALUES 
(3, '12.345.678/0001-90', 'Carlos Oliveira', 'Pet Shop', 'Segunda a Sábado, 8h às 20h');

-- Inserir pets de teste
INSERT INTO pet (id, name, type, weight, age, activity_level, breed, notes, tutor_id, created_at, updated_at) VALUES
(1, 'Rex', 'Cachorro', 15.5, 3, 'Alto', 'Golden Retriever', 'Muito brincalhão', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Luna', 'Gato', 4.2, 2, 'Médio', 'Siamês', 'Muito carinhosa', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Inserir produtos de teste
INSERT INTO product (id, name, description, price, image_url, measurement_unit, owner_id, owner_name, owner_location, owner_phone, created_at, updated_at) VALUES
(1, 'Ração Premium', 'Ração de alta qualidade para cães adultos', 89.90, 'https://example.com/racao.jpg', 'kg', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Brinquedo Interativo', 'Brinquedo para estimular a mente do pet', 45.90, 'https://example.com/brinquedo.jpg', 'unidade', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Inserir serviços veterinários de teste
INSERT INTO vet_service (id, name, description, price, owner_id, owner_name, owner_location, owner_phone, owner_crmv, operating_hours, created_at, updated_at) VALUES
(1, 'Consulta Veterinária', 'Consulta completa com exame físico', 150.00, 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', '12345-SP', 'Segunda a Sexta, 8h às 18h', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Vacinação', 'Aplicação de vacinas essenciais', 80.00, 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', '12345-SP', 'Segunda a Sexta, 8h às 18h', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 