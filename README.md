# 🐾 PetConnect Backend - API REST para Gestão Pet

## 🎯 Visão Geral

O backend do **PetConnect** é uma API REST robusta desenvolvida com **Spring Boot** que serve como a espinha dorsal para todo o ecossistema PetConnect. Ele gerencia a lógica de negócios, a autenticação de usuários e a persistência de dados, fornecendo endpoints seguros e eficientes para a aplicação frontend.

## ✨ Principais Funcionalidades

- **API RESTful Completa**: Endpoints bem definidos para todas as operações de CRUD (Criar, Ler, Atualizar, Excluir) de usuários, pets, produtos e serviços.
- **Autenticação e Autorização**: Sistema seguro baseado em **JSON Web Tokens (JWT)** e **Spring Security**, com diferentes níveis de acesso para cada tipo de usuário (Tutor, Lojista, Veterinário, Admin).
- **Modelo de Dados Relacional**: Estrutura de banco de dados projetada com **JPA/Hibernate**, utilizando herança (`SINGLE_TABLE`) para modelar os diferentes tipos de usuários de forma eficiente.
- **Persistência de Dados**: Configurado para que os dados não sejam apagados a cada reinicialização, permitindo um ambiente de desenvolvimento estável.
- **Dados Iniciais Padronizados**: Um conjunto de dados de exemplo (4 pets, 4 produtos e 4 serviços) é populado no primeiro boot para facilitar testes e demonstrações.

## 🏗️ Arquitetura e Tecnologias

### Stack Tecnológico
- **Java 17** - Linguagem de programação principal.
- **Spring Boot** - Framework para criação da API.
- **Spring Security** - Para autenticação e autorização.
- **Spring Data JPA / Hibernate** - Para persistência de dados e ORM.
- **PostgreSQL** - Banco de dados relacional.
- **JWT (Java Web Token)** - Para gerenciamento de sessões stateless.
- **Maven** - Para gerenciamento de dependências e build do projeto.

### Estrutura do Projeto
A estrutura do projeto segue a convenção do Spring Boot, separando as responsabilidades em camadas de Controller, Model e Repository.

```
backend/
├── src/main/java/com/petconect/backend/
│   ├── config/                          # Configurações de Segurança, CORS e JWT
│   ├── controller/                      # Controllers REST (Endpoints da API)
│   ├── model/                           # Entidades JPA (Modelo de Dados)
│   └── repository/                      # Repositórios (Acesso ao Banco de Dados)
└── src/main/resources/
    ├── application.properties          # Configurações da aplicação e do banco
    ├── schema.sql                      # Schema do banco de dados (sem DROP)
    └── data.sql                        # Dados iniciais para popular o banco
```

## 🚀 Como Executar

1.  **Pré-requisitos**:
    - [JDK 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) ou superior.
    - [Maven](https://maven.apache.org/download.cgi) instalado.
    - [PostgreSQL](https://www.postgresql.org/download/) instalado e um banco de dados chamado `petconnect` criado.

2.  **Configure o `application.properties`**:
    - Verifique e ajuste as credenciais do banco de dados em `src/main/resources/application.properties` se necessário.

3.  **Compile e execute o projeto**:
```bash
mvn spring-boot:run
```

A API estará disponível em `http://localhost:8080`.

## Endpoints Principais

- `POST /api/auth/register-{type}`: Registra um novo usuário (tutor, lojista, vet).
- `POST /api/auth/login`: Autentica um usuário e retorna um token JWT.
- `GET /api/pets`: Retorna a lista de pets (requer autenticação).
- `POST /api/pets`: Cria um novo pet (requer autenticação de Tutor).
- ... e muitos outros. Consulte o código nos `controllers` para a lista completa.

## 🧑‍💻 Desenvolvido por

- **Jesse V.**
- **E-mail**: jessevvv63@gmail.com
- **GitHub**: [jessevvv](https://github.com/jessevvv)

---

Este README foi atualizado para refletir o estado atual do projeto, incluindo as últimas funcionalidades e melhorias implementadas. 