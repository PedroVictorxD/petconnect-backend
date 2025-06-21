-- Schema do banco de dados PetConnect
-- Este script define a estrutura das tabelas

-- Tabela de usuários (classe base)
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    location VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dtype VARCHAR(31) NOT NULL
);

-- Tabela de tutores
CREATE TABLE IF NOT EXISTS tutor (
    id BIGINT PRIMARY KEY REFERENCES users(id)
);

-- Tabela de veterinários
CREATE TABLE IF NOT EXISTS veterinario (
    id BIGINT PRIMARY KEY REFERENCES users(id),
    crmv VARCHAR(20) UNIQUE NOT NULL
);

-- Tabela de lojistas
CREATE TABLE IF NOT EXISTS lojista (
    id BIGINT PRIMARY KEY REFERENCES users(id),
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    responsible_name VARCHAR(255) NOT NULL,
    store_type VARCHAR(100) NOT NULL,
    operating_hours TEXT
);

-- Tabela de administradores
CREATE TABLE IF NOT EXISTS admin (
    id BIGINT PRIMARY KEY REFERENCES users(id)
);

-- Tabela de pets
CREATE TABLE IF NOT EXISTS pet (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    weight DOUBLE PRECISION NOT NULL,
    age INTEGER NOT NULL,
    activity_level VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    notes TEXT,
    tutor_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS product (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    image_url VARCHAR(500),
    measurement_unit VARCHAR(50),
    owner_id BIGINT REFERENCES users(id),
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de serviços veterinários
CREATE TABLE IF NOT EXISTS vet_service (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    owner_id BIGINT REFERENCES users(id),
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(20),
    owner_crmv VARCHAR(20),
    operating_hours TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de lojas (opcional)
CREATE TABLE IF NOT EXISTS store (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(500),
    phone VARCHAR(20),
    email VARCHAR(255),
    owner_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de alimentos (opcional)
CREATE TABLE IF NOT EXISTS food (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand VARCHAR(255),
    type VARCHAR(100),
    age_group VARCHAR(50),
    size VARCHAR(50),
    price DOUBLE PRECISION,
    owner_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de perguntas de segurança
CREATE TABLE IF NOT EXISTS security_question (
    id BIGSERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    answer VARCHAR(255) NOT NULL,
    user_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhorar performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_pet_tutor_id ON pet(tutor_id);
CREATE INDEX IF NOT EXISTS idx_product_owner_id ON product(owner_id);
CREATE INDEX IF NOT EXISTS idx_vet_service_owner_id ON vet_service(owner_id);
CREATE INDEX IF NOT EXISTS idx_veterinario_crmv ON veterinario(crmv);
CREATE INDEX IF NOT EXISTS idx_lojista_cnpj ON lojista(cnpj);

-- Comentários nas tabelas
COMMENT ON TABLE users IS 'Tabela base para todos os tipos de usuários do sistema';
COMMENT ON TABLE pet IS 'Tabela de pets cadastrados pelos tutores';
COMMENT ON TABLE product IS 'Tabela de produtos vendidos pelos lojistas';
COMMENT ON TABLE vet_service IS 'Tabela de serviços oferecidos pelos veterinários';
COMMENT ON TABLE store IS 'Tabela de lojas físicas dos lojistas';
COMMENT ON TABLE food IS 'Tabela de alimentos específicos para pets';
COMMENT ON TABLE security_question IS 'Tabela de perguntas de segurança para recuperação de senha'; 