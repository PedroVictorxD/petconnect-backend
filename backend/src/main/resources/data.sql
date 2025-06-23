-- Dados iniciais para o sistema PetConnect
-- Este script será executado automaticamente pelo Spring Boot

-- Inserir usuários de teste na tabela base 'users' com senhas codificadas com BCrypt
-- Senha para todos os usuários de teste é "admin123" (codificada com BCrypt)
-- IDs são omitidos para permitir que a sequência do banco de dados os gere automaticamente.
INSERT INTO users (dtype, name, email, password, phone, location, created_at, updated_at, crmv, cnpj, responsible_name, operating_hours, store_type) VALUES
-- Tutor
('TUTOR', 'João Silva', 'tutor@teste.com', '$2a$10$RZWPNXMiFC2H64rLZrdWReCZO444SeYbd9q.PdCIsbw5m9e9vNQES', '(11) 99999-9999', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, NULL, NULL, NULL, NULL),
-- Veterinario
('VETERINARIO', 'Dr. Maria Santos', 'vet@teste.com', '$2a$10$RZWPNXMiFC2H64rLZrdWReCZO444SeYbd9q.PdCIsbw5m9e9vNQES', '(11) 88888-8888', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'CRMV-SP 12345', NULL, NULL, NULL, NULL),
-- Lojista
('LOJISTA', 'PetShop Central', 'lojista@teste.com', '$2a$10$RZWPNXMiFC2H64rLZrdWReCZO444SeYbd9q.PdCIsbw5m9e9vNQES', '(11) 77777-7777', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, '00.000.000/0001-00', 'João da Silva', 'Segunda a Sexta, 8h às 18h', 'Petshop'),
-- Admin
('ADMIN', 'Administrador', 'admin@teste.com', '$2a$10$RZWPNXMiFC2H64rLZrdWReCZO444SeYbd9q.PdCIsbw5m9e9vNQES', '(11) 66666-6666', 'São Paulo, SP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL, NULL, NULL, NULL, NULL);

-- Inserir pets de teste (associados ao Tutor ID 1)
INSERT INTO pet (name, type, weight, age, activity_level, breed, notes, tutor_id, photo_url) VALUES
('Rex', 'Cachorro', 15.5, 3, 'Alto', 'Golden Retriever', 'Muito brincalhão', 1, 'https://images.unsplash.com/photo-1558788353-f76d92427f16?auto=format&fit=crop&w=400&h=300&q=80'),
('Luna', 'Gato', 4.2, 2, 'Médio', 'Siamês', 'Muito carinhosa', 1, 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?auto=format&fit=crop&w=400&h=300&q=80'),
('Buddy', 'Cachorro', 12.0, 2, 'Alto', 'Border Collie', 'Muito inteligente e ativo', 1, 'https://images.unsplash.com/photo-1507146426996-ef05306b995a?auto=format&fit=crop&w=400&h=300&q=80'),
('Mittens', 'Gato', 3.5, 1, 'Baixo', 'Persa', 'Calmo e tranquilo', 1, 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=400&h=300&q=80');

-- Inserir produtos de teste (associados ao Lojista ID 3)
INSERT INTO product (name, description, price, image_url, measurement_unit, owner_id, owner_name, owner_location, owner_phone) VALUES
('Ração Premium', 'Ração de alta qualidade para cães adultos', 89.90, 'https://images.unsplash.com/photo-1601758228041-3caa1532c761?auto=format&fit=crop&w=400&h=300&q=80', 'kg', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777'),
('Brinquedo Interativo', 'Brinquedo para estimular a mente do pet', 45.90, 'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?auto=format&fit=crop&w=400&h=300&q=80', 'unidade', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777'),
('Coleira Ajustável', 'Coleira confortável e segura para passeios', 78.50, 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?auto=format&fit=crop&w=400&h=300&q=80', 'unidade', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777'),
('Cama para Pet', 'Cama confortável para descanso do pet', 120.00, 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?auto=format&fit=crop&w=400&h=300&q=80', 'unidade', 3, 'PetShop Central', 'São Paulo, SP', '(11) 77777-7777');

-- Inserir serviços veterinários de teste (associados ao Veterinario ID 2)
INSERT INTO vet_service (name, description, price, image_url, owner_id, owner_name, owner_location, owner_phone, owner_crmv, operating_hours) VALUES
('Consulta Veterinária', 'Consulta completa com exame físico', 150.00, 'https://images.unsplash.com/photo-1583269555433-b46d5a1815e9?auto=format&fit=crop&w=400&h=300&q=80', 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h'),
('Vacinação', 'Aplicação de vacinas essenciais', 80.00, 'https://images.unsplash.com/photo-1599442033324-1c99256a4697?auto=format&fit=crop&w=400&h=300&q=80', 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h'),
('Castração', 'Procedimento cirúrgico de castração', 450.00, 'https://images.unsplash.com/photo-1549483369-262c315b8134?auto=format&fit=crop&w=400&h=300&q=80', 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h'),
('Exame de Sangue', 'Exame laboratorial completo', 200.00, 'https://images.unsplash.com/photo-1606323863450-c8374e2d8376?auto=format&fit=crop&w=400&h=300&q=80', 2, 'Dr. Maria Santos', 'São Paulo, SP', '(11) 88888-8888', 'CRMV-SP 12345', 'Segunda a Sexta, 8h às 18h');

-- Reinicia a sequência de IDs para o próximo valor disponível após os inserts manuais.
-- Isso previne erros de "duplicate key" ao criar novos registros pela aplicação.
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users), true); 