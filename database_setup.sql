-- Script de configuração do banco de dados PetConnect
-- Execute este script como usuário postgres

-- Criar o banco de dados
CREATE DATABASE petconnect;

-- Conectar ao banco de dados
\c petconnect;

-- Criar extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Comentário sobre o esquema
COMMENT ON DATABASE petconnect IS 'Banco de dados do sistema PetConnect - Plataforma de conexão entre tutores, veterinários e lojistas';

-- Configurações de timezone
SET timezone = 'America/Sao_Paulo'; 