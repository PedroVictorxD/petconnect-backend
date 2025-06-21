#!/bin/bash

# Script de configuração do PostgreSQL para o PetConnect
echo "🐾 Configurando PostgreSQL para o PetConnect..."

# Verificar se o PostgreSQL está instalado
if ! command -v psql &> /dev/null; then
    echo "📦 Instalando PostgreSQL..."
    sudo apt update
    sudo apt install -y postgresql postgresql-contrib
    echo "✅ PostgreSQL instalado com sucesso!"
else
    echo "✅ PostgreSQL já está instalado!"
fi

# Iniciar o serviço PostgreSQL
echo "🚀 Iniciando serviço PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Configurar usuário postgres
echo "🔧 Configurando usuário postgres..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

# Criar banco de dados
echo "🗄️ Criando banco de dados petconnect..."
sudo -u postgres psql -c "CREATE DATABASE petconnect;"

# Executar script de configuração
echo "📝 Executando script de configuração..."
sudo -u postgres psql -d petconnect -f database_setup.sql

echo "✅ Configuração do PostgreSQL concluída!"
echo "📊 Banco de dados: petconnect"
echo "👤 Usuário: postgres"
echo "🔑 Senha: postgres"
echo "🌐 Host: localhost"
echo "🔌 Porta: 5432"

echo ""
echo "🚀 Para iniciar o backend, execute:"
echo "cd backend && mvn spring-boot:run" 