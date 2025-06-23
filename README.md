# 🐾 PetConnect - Sistema de Gestão de Pets

## 📋 Índice
- [Visão Geral](#visão-geral)
- [Arquitetura do Sistema](#arquitetura-do-sistema)
- [Backend](#backend)
- [Frontend](#frontend)
- [Roteiro do Sistema](#roteiro-do-sistema)
- [Funcionalidades Detalhadas](#funcionalidades-detalhadas)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Instalação e Configuração](#instalação-e-configuração)
- [API Endpoints](#api-endpoints)
- [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)

---

## 🎯 Visão Geral

O **PetConnect** é uma plataforma completa de gestão de pets que conecta **Tutores**, **Lojistas** e **Veterinários** em um ecossistema integrado. O sistema permite o cadastro e gerenciamento de pets, produtos pet e serviços veterinários, facilitando a comunicação entre todos os envolvidos no cuidado animal.

### 🎪 Principais Atores
- **Tutores**: Cadastram e gerenciam seus pets, exploram produtos e serviços
- **Lojistas**: Gerenciam produtos pet, visualizam pets da plataforma
- **Veterinários**: Oferecem serviços veterinários, visualizam pets e contatam tutores

---

## 🏗️ Arquitetura do Sistema

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend      │    │   Database      │
│   (Flutter)     │◄──►│   (Spring Boot) │◄──►│  (PostgreSQL)   │
│                 │    │                 │    │                 │
│ • Web App       │    │ • REST API      │    │ • Users         │
│ • Responsive    │    │ • JWT Auth      │    │ • Pets          │
│ • PWA Ready     │    │ • CORS Config   │    │ • Products      │
└─────────────────┘    └─────────────────┘    │ • Services      │
                                              └─────────────────┘
```

---

## 🔧 Backend

### 📁 Estrutura do Projeto
```
backend/
├── src/main/java/com/petconect/backend/
│   ├── BackendApplication.java          # Classe principal
│   ├── config/                          # Configurações
│   │   ├── CorsConfig.java             # CORS
│   │   ├── SecurityConfig.java         # Segurança
│   │   ├── JwtUtil.java                # JWT
│   │   ├── JwtRequestFilter.java       # Filtro JWT
│   │   └── UserDetailsServiceImpl.java # UserDetails
│   ├── controller/                      # Controllers REST
│   │   ├── AuthController.java         # Autenticação
│   │   ├── PetController.java          # Pets
│   │   ├── ProductController.java      # Produtos
│   │   ├── VetServiceController.java   # Serviços
│   │   ├── AdminController.java        # Admin
│   │   └── GlobalExceptionHandler.java # Tratamento de erros
│   ├── model/                          # Entidades JPA
│   │   ├── User.java                   # Usuário base
│   │   ├── Tutor.java                  # Tutor
│   │   ├── Lojista.java                # Lojista
│   │   ├── Veterinario.java            # Veterinário
│   │   ├── Pet.java                    # Pet
│   │   ├── Product.java                # Produto
│   │   └── VetService.java             # Serviço veterinário
│   └── repository/                     # Repositórios
│       ├── UserRepository.java         # Usuários
│       ├── PetRepository.java          # Pets
│       ├── ProductRepository.java      # Produtos
│       └── VetServiceRepository.java   # Serviços
└── src/main/resources/
    ├── application.properties          # Configurações
    ├── schema.sql                      # Schema do banco
    └── data.sql                        # Dados iniciais
```

### 🔐 Sistema de Autenticação
- **JWT (JSON Web Tokens)** para autenticação
- **BCrypt** para criptografia de senhas
- **Spring Security** para autorização
- **CORS** configurado para frontend

### 🗄️ Banco de Dados
- **PostgreSQL** como banco principal
- **JPA/Hibernate** para ORM
- **Herança** implementada para diferentes tipos de usuário
- **Relacionamentos** entre entidades

---

## 🎨 Frontend

### 📁 Estrutura do Projeto
```
petconnect-frontend/
├── lib/
│   ├── main.dart                       # Ponto de entrada
│   ├── core/                           # Core do sistema
│   │   ├── api/
│   │   │   └── api_client.dart         # Cliente HTTP
│   │   └── models/                     # Modelos
│   │       ├── user.dart               # Usuário
│   │       ├── pet.dart                # Pet
│   │       ├── product.dart            # Produto
│   │       └── vet_service.dart        # Serviço
│   ├── features/                       # Funcionalidades
│   │   ├── auth/                       # Autenticação
│   │   │   ├── login_screen.dart       # Login
│   │   │   ├── register_screen.dart    # Registro
│   │   │   └── user_type_selection.dart # Seleção de tipo
│   │   ├── tutor/                      # Tela do tutor
│   │   │   └── tutor_home_screen.dart  # Dashboard tutor
│   │   ├── lojista/                    # Tela do lojista
│   │   │   └── lojista_home_screen.dart # Dashboard lojista
│   │   ├── veterinario/                # Tela do veterinário
│   │   │   └── vet_home_screen.dart    # Dashboard vet
│   │   ├── admin/                      # Tela do admin
│   │   │   └── admin_home_screen.dart  # Dashboard admin
│   │   └── landing/                    # Landing page
│   │       └── landing_page.dart       # Página inicial
│   ├── providers/                      # Gerenciamento de estado
│   │   ├── auth_provider.dart          # Estado de autenticação
│   │   └── data_provider.dart          # Estado dos dados
│   └── services/                       # Serviços
│       └── api_service.dart            # Serviços de API
├── web/                                # Configuração web
│   ├── index.html                      # HTML principal
│   └── manifest.json                   # Manifest PWA
└── pubspec.yaml                        # Dependências
```

### 🎯 Características do Frontend
- **Flutter Web** para aplicação web responsiva
- **Provider** para gerenciamento de estado
- **HTTP Client** para comunicação com API
- **PWA Ready** para instalação como app
- **Design Responsivo** para diferentes dispositivos

---

## 🗺️ Roteiro do Sistema

### 1. **Fluxo de Registro e Login**
```
1. Usuário acessa a aplicação
   ↓
2. Escolhe entre Login ou Registro
   ↓
3. Se Registro:
   - Seleciona tipo de usuário (Tutor/Lojista/Veterinário)
   - Preenche dados pessoais
   - Sistema cria conta e redireciona para dashboard
   ↓
4. Se Login:
   - Informa email e senha
   - Sistema valida credenciais
   - Gera JWT token
   - Redireciona para dashboard específico
```

### 2. **Fluxo do Tutor**
```
1. Dashboard do Tutor
   ↓
2. Gerencia Pets:
   - Cadastra novos pets
   - Edita informações dos pets
   - Visualiza lista de pets
   - Exclui pets
   ↓
3. Explora Produtos:
   - Visualiza produtos disponíveis
   - Vê detalhes dos produtos
   - Contata lojistas via WhatsApp
   ↓
4. Explora Serviços:
   - Visualiza serviços veterinários
   - Vê detalhes dos serviços
   - Contata veterinários via WhatsApp
   ↓
5. Calculadora de Ração:
   - Calcula quantidade de ração
   - Baseado no peso e tipo do pet
```

### 3. **Fluxo do Lojista**
```
1. Dashboard do Lojista
   ↓
2. Gerencia Produtos:
   - Cadastra novos produtos
   - Edita produtos existentes
   - Exclui produtos
   - Visualiza lista de produtos
   ↓
3. Visualiza Pets:
   - Vê pets cadastrados na plataforma
   - Clica nos cards para ver detalhes
   - Visualiza informações dos tutores
   ↓
4. Métricas:
   - Vê quantidade de produtos
   - Vê quantidade de pets na plataforma
```

### 4. **Fluxo do Veterinário**
```
1. Dashboard do Veterinário
   ↓
2. Gerencia Serviços:
   - Cadastra novos serviços
   - Edita serviços existentes
   - Exclui serviços
   - Visualiza lista de serviços
   ↓
3. Visualiza Pets:
   - Vê pets cadastrados na plataforma
   - Clica nos cards para ver detalhes
   - Visualiza informações dos tutores
   - Contata tutores via WhatsApp
   ↓
4. Métricas:
   - Vê quantidade de serviços
   - Vê quantidade de pets atendidos
```

### 5. **Fluxo do Admin**
```
1. Dashboard do Admin
   ↓
2. Estatísticas Gerais:
   - Total de usuários por tipo
   - Total de pets cadastrados
   - Total de produtos
   - Total de serviços
   ↓
3. Monitoramento:
   - Visualiza dados do sistema
   - Acompanha crescimento da plataforma
```

---

## ⚙️ Funcionalidades Detalhadas

### 🔐 Autenticação e Autorização
- **Registro**: Criação de contas com validação de dados
- **Login**: Autenticação com JWT
- **Autorização**: Controle de acesso baseado em tipo de usuário
- **Logout**: Encerramento de sessão

### 🐕 Gestão de Pets
- **Cadastro**: Nome, tipo, raça, idade, peso, nível de atividade, notas
- **Edição**: Atualização de informações
- **Exclusão**: Remoção de pets
- **Visualização**: Cards com informações resumidas
- **Detalhes**: Modal com informações completas
- **Imagens**: Upload de fotos (opcional)

### 🛍️ Gestão de Produtos
- **Cadastro**: Nome, descrição, preço, categoria, imagem (opcional)
- **Edição**: Atualização de informações
- **Exclusão**: Remoção de produtos
- **Visualização**: Cards com informações e preços
- **Detalhes**: Modal com informações completas e contato
- **Contato**: Integração com WhatsApp

### 🏥 Gestão de Serviços Veterinários
- **Cadastro**: Nome, descrição, preço, horários, imagem (opcional)
- **Edição**: Atualização de informações
- **Exclusão**: Remoção de serviços
- **Visualização**: Cards com informações e preços
- **Detalhes**: Modal com informações completas e contato
- **Contato**: Integração com WhatsApp

### 📱 Integração WhatsApp
- **Contato Direto**: Clique no telefone abre WhatsApp
- **Formatação**: Limpeza automática do número
- **Código do País**: Adição automática do código +55 (Brasil)

### 🧮 Calculadora de Ração
- **Cálculo Automático**: Baseado no peso e tipo do pet
- **Diferentes Tipos**: Cachorro e Gato
- **Níveis de Atividade**: Baixo, Médio, Alto
- **Resultado**: Quantidade diária recomendada

### 📊 Métricas e Estatísticas
- **Dashboard**: Informações resumidas para cada tipo de usuário
- **Contadores**: Quantidade de itens por categoria
- **Admin**: Estatísticas gerais do sistema

---

## 🛠️ Tecnologias Utilizadas

### Backend
- **Java 17**: Linguagem principal
- **Spring Boot 3**: Framework principal
- **Spring Security**: Segurança e autenticação
- **Spring Data JPA**: Persistência de dados
- **PostgreSQL**: Banco de dados
- **JWT**: Autenticação stateless
- **Maven**: Gerenciamento de dependências
- **Lombok**: Redução de boilerplate

### Frontend
- **Flutter 3**: Framework de desenvolvimento
- **Dart**: Linguagem de programação
- **Provider**: Gerenciamento de estado
- **HTTP**: Comunicação com API
- **url_launcher**: Integração com WhatsApp
- **Flutter Web**: Compilação para web

### DevOps
- **Git**: Controle de versão
- **GitHub**: Repositório remoto
- **PostgreSQL**: Banco de dados local

---

## 🚀 Instalação e Configuração

### Pré-requisitos
- Java 17 ou superior
- Flutter 3.0 ou superior
- PostgreSQL 12 ou superior
- Maven 3.6 ou superior

### Backend
```bash
# Clone o repositório
git clone <repository-url>
cd petconnect-backend-only/backend

# Configure o banco de dados
# Edite application.properties com suas credenciais

# Execute o projeto
./mvnw spring-boot:run
```

### Frontend
```bash
# Navegue para o diretório do frontend
cd petconnect-frontend

# Instale as dependências
flutter pub get

# Execute o projeto
flutter run -d chrome
```

### Configuração do Banco
```sql
-- Crie o banco de dados
CREATE DATABASE petconnect;

-- O schema será criado automaticamente pelo Spring Boot
```

---

## 🔌 API Endpoints

### Autenticação
- `POST /api/register` - Registro de usuário
- `POST /api/login` - Login de usuário

### Pets
- `GET /api/pets` - Listar todos os pets
- `POST /api/pets` - Criar novo pet
- `PUT /api/pets/{id}` - Atualizar pet
- `DELETE /api/pets/{id}` - Excluir pet

### Produtos
- `GET /api/products` - Listar todos os produtos
- `POST /api/products` - Criar novo produto
- `PUT /api/products/{id}` - Atualizar produto
- `DELETE /api/products/{id}` - Excluir produto

### Serviços Veterinários
- `GET /api/services` - Listar todos os serviços
- `POST /api/services` - Criar novo serviço
- `PUT /api/services/{id}` - Atualizar serviço
- `DELETE /api/services/{id}` - Excluir serviço

### Admin
- `GET /api/admin/stats` - Estatísticas do sistema

---

## 🗄️ Estrutura do Banco de Dados

### Tabela `users` (Herança)
```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    location VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dtype VARCHAR(31) NOT NULL -- TUTOR, LOJISTA, VETERINARIO
);

-- Campos específicos para Lojista
ALTER TABLE users ADD COLUMN cnpj VARCHAR(18);
ALTER TABLE users ADD COLUMN store_type VARCHAR(100);
ALTER TABLE users ADD COLUMN responsible_name VARCHAR(255);

-- Campos específicos para Veterinário
ALTER TABLE users ADD COLUMN crmv VARCHAR(50);
ALTER TABLE users ADD COLUMN operating_hours VARCHAR(255);
```

### Tabela `pets`
```sql
CREATE TABLE pets (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    age INTEGER NOT NULL,
    weight DOUBLE PRECISION NOT NULL,
    photo_url TEXT,
    activity_level VARCHAR(50),
    notes TEXT,
    tutor_id BIGINT REFERENCES users(id)
);
```

### Tabela `products`
```sql
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    image_url TEXT,
    category VARCHAR(100),
    measurement_unit VARCHAR(50),
    owner_id BIGINT REFERENCES users(id),
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(20)
);
```

### Tabela `vet_service`
```sql
CREATE TABLE vet_service (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    image_url TEXT,
    operating_hours VARCHAR(255),
    owner_id BIGINT REFERENCES users(id),
    owner_name VARCHAR(255),
    owner_location VARCHAR(255),
    owner_phone VARCHAR(20),
    owner_crmv VARCHAR(50)
);
```

---

## 📈 Funcionalidades Futuras

### Planejadas
- [ ] Sistema de agendamento de consultas
- [ ] Chat em tempo real entre usuários
- [ ] Sistema de avaliações e comentários
- [ ] Notificações push
- [ ] Upload de imagens para servidor
- [ ] Sistema de pagamentos
- [ ] Relatórios avançados
- [ ] App mobile nativo

### Melhorias Técnicas
- [ ] Cache Redis para performance
- [ ] Testes automatizados
- [ ] CI/CD pipeline
- [ ] Docker containerization
- [ ] Monitoramento e logs
- [ ] Backup automático

---

## 🤝 Contribuição

### Como Contribuir
1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Padrões de Código
- **Backend**: Seguir convenções Java e Spring Boot
- **Frontend**: Seguir convenções Dart e Flutter
- **Commits**: Usar mensagens descritivas em português
- **Documentação**: Manter documentação atualizada

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 👥 Autores

- **Pedro** - *Desenvolvimento inicial* - [GitHub](https://github.com/seu-usuario)

---

## 🙏 Agradecimentos

- Comunidade Flutter
- Comunidade Spring Boot
- Tutores, Lojistas e Veterinários que testaram o sistema

---

## 📞 Suporte

Para suporte, envie um email para suporte@petconnect.com ou abra uma issue no GitHub.

---

## 🔄 Histórico de Versões

### v1.0.0 (2025-06-23)
- ✅ Sistema básico funcionando
- ✅ Autenticação JWT
- ✅ CRUD completo para pets, produtos e serviços
- ✅ Integração WhatsApp
- ✅ Calculadora de ração
- ✅ Dashboard para todos os tipos de usuário
- ✅ Interface responsiva
- ✅ Documentação completa

---

*Documentação atualizada em: 23/06/2025* 