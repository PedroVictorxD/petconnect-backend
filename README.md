# 🐾 PetConnect - Sistema de Conexão para Pets

Sistema completo de backend em Spring Boot com PostgreSQL para conectar tutores, veterinários e lojistas.

## 📋 Pré-requisitos

- Java 21+
- Maven 3.6+
- PostgreSQL 12+
- Flutter (para frontend)

## 🚀 Configuração Rápida

### 1. Configurar PostgreSQL.

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

## 📋 Descrição

O PetConnect Backend é uma API REST desenvolvida em Spring Boot que gerencia um sistema completo de conectividade entre tutores de pets, veterinários e lojistas. O sistema permite o cadastro, gerenciamento e interação entre diferentes tipos de usuários e seus respectivos recursos.

## 🏗️ Arquitetura

### Tecnologias Utilizadas
- **Java 17**
- **Spring Boot 3.2.6**
- **Spring Security** (com JWT)
- **Spring Data JPA**
- **PostgreSQL**
- **Maven**
- **Hibernate**

### Estrutura do Projeto
```
src/main/java/com/petconect/backend/
├── BackendApplication.java          # Classe principal
├── config/                          # Configurações
│   ├── CorsConfig.java             # Configuração CORS
│   ├── JwtRequestFilter.java       # Filtro JWT
│   ├── JwtUtil.java                # Utilitários JWT
│   ├── SecurityConfig.java         # Configuração de Segurança
│   └── UserDetailsServiceImpl.java # Implementação UserDetails
├── controller/                      # Controladores REST
│   ├── AdminController.java        # Endpoints do Admin
│   ├── AuthController.java         # Autenticação
│   ├── FoodController.java         # Alimentos
│   ├── ForwardingController.java   # Redirecionamento
│   ├── GlobalExceptionHandler.java # Tratamento de Exceções
│   ├── LojistaController.java      # Endpoints do Lojista
│   ├── PetController.java          # Pets
│   ├── ProductController.java      # Produtos
│   ├── SecurityQuestionController.java # Perguntas de Segurança
│   ├── StoreController.java        # Lojas
│   ├── TutorController.java        # Endpoints do Tutor
│   ├── VeterinarioController.java  # Endpoints do Veterinário
│   └── VetServiceController.java   # Serviços Veterinários
├── model/                          # Entidades JPA
│   ├── Admin.java                  # Administrador
│   ├── Food.java                   # Alimento
│   ├── Lojista.java                # Lojista
│   ├── Pet.java                    # Pet
│   ├── Product.java                # Produto
│   ├── SecurityQuestion.java       # Pergunta de Segurança
│   ├── Store.java                  # Loja
│   ├── Tutor.java                  # Tutor
│   ├── User.java                   # Usuário Base
│   ├── Veterinario.java            # Veterinário
│   └── VetService.java             # Serviço Veterinário
└── repository/                     # Repositórios JPA
    ├── AdminRepository.java
    ├── FoodRepository.java
    ├── LojistaRepository.java
    ├── PetRepository.java
    ├── ProductRepository.java
    ├── SecurityQuestionRepository.java
    ├── StoreRepository.java
    ├── TutorRepository.java
    ├── UserRepository.java
    ├── VeterinarioRepository.java
    └── VetServiceRepository.java
```

## 🔐 Sistema de Autenticação

### JWT (JSON Web Token)
- **Algoritmo:** HS512
- **Tempo de expiração:** 24 horas
- **Segredo:** 512 bits

### Tipos de Usuário
1. **Admin** - Acesso total ao sistema
2. **Tutor** - Gerencia seus pets
3. **Veterinário** - Oferece serviços veterinários
4. **Lojista** - Vende produtos para pets

## 📡 Endpoints da API

### Autenticação
```
POST /api/auth/login
POST /api/auth/register-tutor
POST /api/auth/register-lojista
POST /api/auth/register-veterinario
```

### Admin (Requer autenticação)
```
GET    /api/admin/users           # Listar todos os usuários
PUT    /api/admin/users/{id}      # Atualizar usuário
DELETE /api/admin/users/{id}      # Excluir usuário
GET    /api/admin/stats           # Estatísticas do sistema
POST   /api/admin/admins          # Criar admin
POST   /api/admin/tutors          # Criar tutor
POST   /api/admin/veterinarios    # Criar veterinário
POST   /api/admin/lojistas        # Criar lojista
```

### Pets
```
GET    /api/pets                  # Listar pets
GET    /api/pets?tutorId={id}     # Listar pets por tutor
POST   /api/pets                  # Criar pet
PUT    /api/pets/{id}             # Atualizar pet
DELETE /api/pets/{id}             # Excluir pet
```

### Produtos
```
GET    /api/products              # Listar produtos
POST   /api/products              # Criar produto
PUT    /api/products/{id}         # Atualizar produto
DELETE /api/products/{id}         # Excluir produto
```

### Serviços Veterinários
```
GET    /api/services              # Listar serviços
POST   /api/services              # Criar serviço
PUT    /api/services/{id}         # Atualizar serviço
DELETE /api/services/{id}         # Excluir serviço
```

## 🗄️ Modelo de Dados

### Estratégia de Herança
- **SINGLE_TABLE**: Todos os tipos de usuário na mesma tabela
- **Discriminator:** campo `dtype` identifica o tipo

### Entidades Principais

#### User (Base)
- `id` (Long, PK)
- `name` (String)
- `email` (String, unique)
- `password` (String, BCrypt)
- `phone` (String)
- `location` (String)
- `createdAt` (LocalDateTime)
- `updatedAt` (LocalDateTime)
- `dtype` (String)

#### Pet
- `id` (Long, PK)
- `name` (String)
- `type` (String)
- `breed` (String)
- `age` (Integer)
- `weight` (Double)
- `activityLevel` (String)
- `notes` (String)
- `photoUrl` (String)
- `tutor` (Tutor, FK)

#### Product
- `id` (Long, PK)
- `name` (String)
- `description` (String)
- `price` (Double)
- `imageUrl` (String)
- `measurementUnit` (String)
- `ownerId` (Long)
- `ownerName` (String)
- `ownerLocation` (String)
- `ownerPhone` (String)

#### VetService
- `id` (Long, PK)
- `name` (String)
- `description` (String)
- `price` (Double)
- `ownerId` (Long)
- `ownerName` (String)
- `ownerLocation` (String)
- `ownerPhone` (String)
- `ownerCrmv` (String)
- `operatingHours` (String)

## ⚙️ Configuração

### application.properties
```properties
# Database
spring.datasource.url=jdbc:postgresql://localhost:5432/petconnect
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA/Hibernate
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect

# SQL Scripts
spring.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true

# JWT
jwt.secret=your-secret-key-here-make-it-long-and-secure-at-least-512-bits
jwt.expiration=86400000

# Server
server.port=8080
```

### CORS
Configurado para permitir requisições de qualquer origem:
- **Origem:** `*`
- **Métodos:** GET, POST, PUT, DELETE, OPTIONS
- **Headers:** `*`

## 🚀 Instalação e Execução

### Pré-requisitos
- Java 17 ou superior
- Maven 3.6+
- PostgreSQL 12+
- Git

### Passos de Instalação

1. **Clone o repositório**
```bash
git clone <repository-url>
cd petconnect-backend-only/backend
```

2. **Configure o banco de dados**
```bash
# Crie o banco PostgreSQL
createdb petconnect

# Ou execute o script SQL
psql -U postgres -d petconnect -f database_setup.sql
```

3. **Configure as variáveis de ambiente**
```bash
# Edite application.properties com suas credenciais
nano src/main/resources/application.properties
```

4. **Compile o projeto**
```bash
mvn clean compile
```

5. **Execute a aplicação**
```bash
mvn spring-boot:run
```

### Verificação da Instalação
```bash
# Teste se a API está rodando
curl http://localhost:8080/api/products

# Teste o registro de um usuário
curl -X POST http://localhost:8080/api/auth/register-tutor \
  -H "Content-Type: application/json" \
  -d '{"name":"Teste","email":"teste@teste.com","password":"123456","phone":"11999999999"}'
```

## 🔧 Desenvolvimento

### Estrutura de Branches
- `main` - Código estável
- `develop` - Desenvolvimento
- `feature/*` - Novas funcionalidades
- `hotfix/*` - Correções urgentes

### Padrões de Código
- **Nomenclatura:** camelCase para métodos e variáveis
- **Classes:** PascalCase
- **Constantes:** UPPER_SNAKE_CASE
- **Indentação:** 2 espaços

### Testes
```bash
# Executar testes unitários
mvn test

# Executar testes de integração
mvn verify
```

## 📊 Monitoramento

### Logs
- **Nível:** DEBUG para desenvolvimento
- **Arquivo:** `spring.log`
- **Formato:** JSON estruturado

### Métricas
- **Health Check:** `/actuator/health`
- **Info:** `/actuator/info`
- **Metrics:** `/actuator/metrics`

## 🔒 Segurança

### Autenticação
- **JWT** para autenticação stateless
- **BCrypt** para hash de senhas
- **CORS** configurado adequadamente

### Autorização
- **Role-based access control**
- **Endpoint protection** por tipo de usuário
- **Input validation** em todos os endpoints

### Validações
- **Bean Validation** (@Valid)
- **Custom validators** para regras de negócio
- **Exception handling** global

## 🐛 Troubleshooting

### Problemas Comuns

1. **Erro de conexão com banco**
   - Verifique se o PostgreSQL está rodando
   - Confirme credenciais no `application.properties`

2. **Erro de porta em uso**
   ```bash
   sudo lsof -i :8080
   sudo kill -9 <PID>
   ```

3. **Erro de compilação**
   ```bash
   mvn clean
   mvn compile
   ```

4. **Erro de CORS**
   - Verifique configuração no `CorsConfig.java`
   - Confirme origem do frontend

### Logs de Debug
```bash
# Habilitar logs detalhados
export SPRING_PROFILES_ACTIVE=dev
mvn spring-boot:run
```

## 📝 Changelog

### v1.0.0 (2025-06-21)
- ✅ Sistema de autenticação JWT
- ✅ CRUD completo para todas as entidades
- ✅ Endpoints públicos de registro
- ✅ Sistema de autorização por tipo de usuário
- ✅ Configuração CORS
- ✅ Documentação completa

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Suporte

Para suporte e dúvidas:
- **Email:** suporte@petconnect.com
- **Issues:** GitHub Issues
- **Documentação:** Este README

---

**Desenvolvido com ❤️ pela equipe PetConnect** 