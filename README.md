# 🐾 PetConnect - Sistema de Conexão para Pets

Sistema completo de backend em Spring Boot com PostgreSQL para conectar tutores, veterinários e lojistas.

## 📋 Pré-requisitos

- Java 21+
- Maven 3.6+
- PostgreSQL 12+
- Flutter (para frontend)

## 🚀 Configuração Rápida

### 1. Configurar PostgreSQL

```bash
# Executar o script de configuração
./setup_postgres.sh
```

### 2. Executar o Backend

```bash
cd backend
mvn spring-boot:run
```

O backend estará disponível em: `http://localhost:8080`

### 3. Executar o Frontend

```bash
cd ../petconnect-frontend
flutter run -d chrome
```

O frontend estará disponível em: `http://localhost:3000`

## 🗄️ Estrutura do Banco de Dados

### Tabelas Principais

- **users** - Tabela base para todos os usuários
- **tutor** - Tutores de pets
- **veterinario** - Veterinários com CRMV
- **lojista** - Lojistas com CNPJ
- **admin** - Administradores do sistema
- **pet** - Pets cadastrados pelos tutores
- **product** - Produtos vendidos pelos lojistas
- **vet_service** - Serviços oferecidos pelos veterinários

### Relacionamentos

- Pets → Tutor (tutor_id)
- Produtos → Lojista (owner_id)
- Serviços → Veterinário (owner_id)

## 🔌 Endpoints da API

### Autenticação
- `POST /api/auth/login` - Login de usuários

### Usuários
- `GET /tutores` - Listar tutores
- `POST /tutores` - Criar tutor
- `GET /veterinarios` - Listar veterinários
- `POST /veterinarios` - Criar veterinário
- `GET /lojistas` - Listar lojistas
- `POST /lojistas` - Criar lojista
- `GET /admins` - Listar administradores
- `POST /admins` - Criar administrador

### Pets
- `GET /api/pets` - Listar pets
- `GET /api/pets?tutorId={id}` - Listar pets por tutor
- `POST /api/pets` - Criar pet
- `PUT /api/pets/{id}` - Atualizar pet
- `DELETE /api/pets/{id}` - Deletar pet

### Produtos
- `GET /api/products` - Listar produtos
- `POST /api/products` - Criar produto
- `PUT /api/products/{id}` - Atualizar produto
- `DELETE /api/products/{id}` - Deletar produto

### Serviços Veterinários
- `GET /api/services` - Listar serviços
- `POST /api/services` - Criar serviço
- `PUT /api/services/{id}` - Atualizar serviço
- `DELETE /api/services/{id}` - Deletar serviço

## 👥 Usuários de Teste

### Tutor
- Email: `joao@test.com`
- Senha: `123456`

### Veterinário
- Email: `maria@vet.com`
- Senha: `123456`
- CRMV: `12345-SP`

### Lojista
- Email: `petshop@test.com`
- Senha: `123456`
- CNPJ: `12.345.678/0001-90`

### Administrador
- Email: `admin@petconnect.com`
- Senha: `admin123`

## 🧪 Testes

### Testar Criação de Pet
```bash
curl -X POST http://localhost:8080/api/pets \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Rex",
    "type": "Cachorro",
    "weight": 15.5,
    "age": 3,
    "activityLevel": "Alto",
    "breed": "Golden Retriever",
    "notes": "Muito brincalhão",
    "tutorId": 1
  }'
```

### Testar Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "joao@test.com",
    "password": "123456"
  }'
```

### Verificar Dados no PostgreSQL
```bash
sudo -u postgres psql -d petconnect -c "SELECT COUNT(*) FROM users;"
sudo -u postgres psql -d petconnect -c "SELECT COUNT(*) FROM pet;"
sudo -u postgres psql -d petconnect -c "SELECT COUNT(*) FROM product;"
sudo -u postgres psql -d petconnect -c "SELECT COUNT(*) FROM vet_service;"
```

## 🔧 Configuração do Banco

### Configurações PostgreSQL
- **Host**: localhost
- **Porta**: 5432
- **Banco**: petconnect
- **Usuário**: postgres
- **Senha**: postgres

### Configurações Spring Boot
- **Porta**: 8080
- **DDL**: create-drop (recria tabelas a cada inicialização)
- **Dialect**: PostgreSQL

## 📁 Estrutura do Projeto

```
petconnect-backend-only/
├── backend/
│   ├── src/main/java/com/petconect/backend/
│   │   ├── controller/     # Controllers REST
│   │   ├── model/         # Entidades JPA
│   │   ├── repository/    # Repositórios Spring Data
│   │   └── config/        # Configurações
│   ├── src/main/resources/
│   │   ├── application.properties
│   │   ├── schema.sql
│   │   └── data.sql
│   └── pom.xml
├── database_setup.sql
├── setup_postgres.sh
└── README.md
```

## ✅ Status do Sistema

- ✅ **Backend**: Funcionando com PostgreSQL
- ✅ **API**: Todos os endpoints operacionais
- ✅ **Banco de Dados**: Tabelas criadas e relacionamentos funcionais
- ✅ **Autenticação**: Sistema de login operacional
- ✅ **CRUD**: Operações de criar, ler, atualizar e deletar funcionando
- ✅ **Persistência**: Dados sendo salvos corretamente no PostgreSQL

## 🎯 Funcionalidades Implementadas

1. **Sistema de Usuários**: 4 tipos (Tutor, Veterinário, Lojista, Admin)
2. **Gestão de Pets**: Cadastro e consulta de pets por tutor
3. **Gestão de Produtos**: Cadastro de produtos pelos lojistas
4. **Gestão de Serviços**: Cadastro de serviços pelos veterinários
5. **Autenticação**: Sistema de login para todos os tipos de usuário
6. **API REST**: Endpoints completos para todas as operações
7. **Banco PostgreSQL**: Persistência robusta com relacionamentos

## 🚀 Próximos Passos

1. Implementar autenticação JWT
2. Adicionar validações de dados
3. Implementar upload de imagens
4. Adicionar sistema de agendamento
5. Implementar notificações
6. Adicionar relatórios e dashboards

---

**Sistema PetConnect - Conectando o mundo dos pets! 🐕🐱** 