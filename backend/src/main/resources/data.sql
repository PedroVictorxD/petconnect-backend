-- Dados iniciais para o sistema PetConnect
-- Este script será executado automaticamente pelo Spring Boot

-- Inserir usuários de teste
INSERT INTO users (name, email, password, phone, location, created_at, updated_at, dtype) VALUES
('João Silva', 'tutor@teste.com', '123456', '(11) 99999-9999', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Tutor'),
('Dr. Maria Santos', 'vet@teste.com', '123456', '(11) 88888-8888', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Veterinario'),
('PetShop Central', 'lojista@teste.com', '123456', '(11) 77777-7777', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Lojista'),
('Administrador', 'admin@teste.com', '123456', '(11) 66666-6666', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Admin');

-- Inserir pets de teste
INSERT INTO pet (name, type, weight, age, activity_level, breed, notes, tutor_id, photo_url) VALUES
('Rex', 'Cachorro', 15.5, 3, 'Alto', 'Golden Retriever', 'Muito brincalhão', 2, 'https://images.unsplash.com/photo-1558788353-f76d92427f16?auto=format&fit=facearea&w=256&h=256&facepad=2&q=80'),
('Luna', 'Gato', 4.2, 2, 'Médio', 'Siamês', 'Muito carinhosa', 2, 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?auto=format&fit=facearea&w=256&h=256&facepad=2&q=80');

-- Inserir produtos de teste
INSERT INTO product (name, description, price, image_url, measurement_unit, owner_id, owner_name, owner_location, owner_phone) VALUES
('Ração Premium', 'Ração de alta qualidade para cães adultos', 89.90, 'https://example.com/racao.jpg', 'kg', 4, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777'),
('Brinquedo Interativo', 'Brinquedo para estimular a mente do pet', 45.90, 'https://example.com/brinquedo.jpg', 'unidade', 4, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777');

-- Inserir serviços veterinários de teste
INSERT INTO vet_service (name, description, price, owner_id, owner_name, owner_location, owner_phone, owner_crmv, operating_hours) VALUES
('Consulta Veterinária', 'Consulta completa com exame físico', 150.00, 3, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', '12345-SP', 'Segunda a Sexta, 8h às 18h'),
('Vacinação', 'Aplicação de vacinas essenciais', 80.00, 3, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', '12345-SP', 'Segunda a Sexta, 8h às 18h'); 