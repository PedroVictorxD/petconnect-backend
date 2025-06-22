-- Schema do banco de dados PetConnect
-- Este script define a estrutura das tabelas

-- Drop tables to ensure a clean state on startup
DROP TABLE IF EXISTS vet_service CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS pet CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS food CASCADE;
DROP TABLE IF EXISTS store CASCADE;
DROP TABLE IF EXISTS security_question CASCADE;

-- Create users table for SINGLE_TABLE inheritance
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    dtype VARCHAR(31) NOT NULL,
    name VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    phone VARCHAR(255),
    location VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Veterinario specific
    crmv VARCHAR(255),
    operating_hours VARCHAR(255),
    responsible_name VARCHAR(255),
    -- Lojista specific
    cnpj VARCHAR(255),
    store_type VARCHAR(255)
);

-- Create pet table
CREATE TABLE pet (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    weight DOUBLE PRECISION NOT NULL,
    age INTEGER NOT NULL,
    activity_level VARCHAR(255),
    breed VARCHAR(255),
    notes VARCHAR(255),
    photo_url VARCHAR(255),
    tutor_id BIGINT,
    CONSTRAINT fk_tutor FOREIGN KEY (tutor_id) REFERENCES users(id)
);

-- Create product table
CREATE TABLE product (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    price DOUBLE PRECISION NOT NULL,
    image_url VARCHAR(255),
    measurement_unit VARCHAR(255),
    owner_id BIGINT,
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Create vet_service table
CREATE TABLE vet_service (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    price DOUBLE PRECISION NOT NULL,
    owner_id BIGINT,
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(255),
    owner_crmv VARCHAR(255),
    operating_hours VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Outras tabelas que podem ser necessárias no futuro
CREATE TABLE food (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    brand VARCHAR(255),
    type VARCHAR(255),
    recommended_daily_amount DOUBLE PRECISION NOT NULL,
    notes VARCHAR(255),
    owner_id BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE store (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255),
    cnpj VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    location VARCHAR(255),
    store_type VARCHAR(255),
    owner_id BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE security_question (
    id BIGSERIAL PRIMARY KEY,
    question VARCHAR(255),
    answer VARCHAR(255)
);

-- Índices para melhorar performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_pet_tutor_id ON pet(tutor_id);
CREATE INDEX IF NOT EXISTS idx_product_owner_id ON product(owner_id);
CREATE INDEX IF NOT EXISTS idx_vet_service_owner_id ON vet_service(owner_id);

-- Comentários nas tabelas
COMMENT ON TABLE users IS 'Tabela base para todos os tipos de usuários do sistema';
COMMENT ON TABLE pet IS 'Tabela de pets cadastrados pelos tutores';
COMMENT ON TABLE product IS 'Tabela de produtos vendidos pelos lojistas';
COMMENT ON TABLE vet_service IS 'Tabela de serviços oferecidos pelos veterinários';
COMMENT ON TABLE store IS 'Tabela de lojas físicas dos lojistas';
COMMENT ON TABLE food IS 'Tabela de alimentos específicos para pets';
COMMENT ON TABLE security_question IS 'Tabela de perguntas de segurança para recuperação de senha'; 