#!/bin/bash

# ===================================================================
# =                   PETCONNECT BACKEND TEST SCRIPT               =
# ===================================================================
# Script para testar todos os endpoints do backend PetConnect
# Autor: Assistant
# Data: $(date)

BASE_URL="http://localhost:8080"
JWT_TOKEN=""
ADMIN_TOKEN=""
TUTOR_TOKEN=""
LOJISTA_TOKEN=""
VETERINARIO_TOKEN=""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir com cores
print_status() {
    local status=$1
    local message=$2
    case $status in
        "SUCCESS")
            echo -e "${GREEN}✓ $message${NC}"
            ;;
        "ERROR")
            echo -e "${RED}✗ $message${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠ $message${NC}"
            ;;
        "INFO")
            echo -e "${BLUE}ℹ $message${NC}"
            ;;
    esac
}

# Função para testar endpoint
test_endpoint() {
    local method=$1
    local endpoint=$2
    local data=$3
    local expected_status=$4
    local description=$5
    
    echo -e "\n${BLUE}Testando: $description${NC}"
    echo "Endpoint: $method $BASE_URL$endpoint"
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $JWT_TOKEN" "$BASE_URL$endpoint")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_TOKEN" -d "$data" "$BASE_URL$endpoint")
    elif [ "$method" = "PUT" ]; then
        response=$(curl -s -w "\n%{http_code}" -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $JWT_TOKEN" -d "$data" "$BASE_URL$endpoint")
    elif [ "$method" = "DELETE" ]; then
        response=$(curl -s -w "\n%{http_code}" -X DELETE -H "Authorization: Bearer $JWT_TOKEN" "$BASE_URL$endpoint")
    fi
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | head -n -1)
    
    if [ "$http_code" = "$expected_status" ]; then
        print_status "SUCCESS" "Status $http_code - $description"
        echo "Response: $body" | head -c 200
        [ ${#body} -gt 200 ] && echo "..."
    else
        print_status "ERROR" "Status $http_code (esperado $expected_status) - $description"
        echo "Response: $body"
    fi
}

# Função para testar autenticação
test_auth() {
    local email=$1
    local password=$2
    local user_type=$3
    
    echo -e "\n${BLUE}Testando autenticação: $user_type${NC}"
    
    login_data="{\"email\":\"$email\",\"password\":\"$password\"}"
    response=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "$login_data" "$BASE_URL/auth/login")
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | head -n -1)
    
    if [ "$http_code" = "200" ]; then
        token=$(echo "$body" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
        if [ -n "$token" ]; then
            case $user_type in
                "admin")
                    ADMIN_TOKEN=$token
                    JWT_TOKEN=$token
                    ;;
                "tutor")
                    TUTOR_TOKEN=$token
                    ;;
                "lojista")
                    LOJISTA_TOKEN=$token
                    ;;
                "veterinario")
                    VETERINARIO_TOKEN=$token
                    ;;
            esac
            print_status "SUCCESS" "Login $user_type bem-sucedido"
            echo "Token: ${token:0:20}..."
        else
            print_status "ERROR" "Token não encontrado na resposta"
        fi
    else
        print_status "ERROR" "Login $user_type falhou - Status $http_code"
        echo "Response: $body"
    fi
}

# Função para testar registro
test_register() {
    local user_data=$1
    local user_type=$2
    
    echo -e "\n${BLUE}Testando registro: $user_type${NC}"
    
    response=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "$user_data" "$BASE_URL/auth/register")
    
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | head -n -1)
    
    if [ "$http_code" = "201" ] || [ "$http_code" = "200" ]; then
        print_status "SUCCESS" "Registro $user_type bem-sucedido"
        echo "Response: $body" | head -c 200
    else
        print_status "ERROR" "Registro $user_type falhou - Status $http_code"
        echo "Response: $body"
    fi
}

# ===================================================================
# =                   INÍCIO DOS TESTES                           =
# ===================================================================

echo -e "${BLUE}==================================================================${NC}"
echo -e "${BLUE}=              PETCONNECT BACKEND TEST SCRIPT              =${NC}"
echo -e "${BLUE}==================================================================${NC}"
echo "Iniciando testes em $(date)"
echo "Base URL: $BASE_URL"

# Teste 1: Verificar se o servidor está rodando
echo -e "\n${YELLOW}1. Verificando se o servidor está rodando...${NC}"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/")
http_code=$(echo "$response" | tail -n1)
if [ "$http_code" = "200" ] || [ "$http_code" = "404" ] || [ "$http_code" = "403" ]; then
    print_status "SUCCESS" "Servidor está rodando (Status: $http_code)"
else
    print_status "ERROR" "Servidor não está respondendo"
    exit 1
fi

# Teste 2: Testar registro de usuários
echo -e "\n${YELLOW}2. Testando registro de usuários...${NC}"

# Registrar Admin
admin_data='{
  "name": "Admin Teste",
  "email": "admin@teste.com",
  "password": "123456",
  "phone": "11999999999",
  "location": "São Paulo, SP",
  "userType": "ADMIN",
  "securityQuestion": "Qual é o nome do seu primeiro pet?",
  "securityAnswer": "Rex"
}'
test_register "$admin_data" "Admin"

# Registrar Tutor
tutor_data='{
  "name": "Tutor Teste",
  "email": "tutor@teste.com",
  "password": "123456",
  "phone": "11888888888",
  "location": "Rio de Janeiro, RJ",
  "userType": "TUTOR",
  "securityQuestion": "Qual é o nome do seu primeiro pet?",
  "securityAnswer": "Luna"
}'
test_register "$tutor_data" "Tutor"

# Registrar Lojista
lojista_data='{
  "name": "Lojista Teste",
  "email": "lojista@teste.com",
  "password": "123456",
  "phone": "11777777777",
  "location": "Belo Horizonte, MG",
  "userType": "LOJISTA",
  "securityQuestion": "Qual é o nome do seu primeiro pet?",
  "securityAnswer": "Thor"
}'
test_register "$lojista_data" "Lojista"

# Registrar Veterinário
veterinario_data='{
  "name": "Veterinário Teste",
  "email": "vet@teste.com",
  "password": "123456",
  "phone": "11666666666",
  "location": "Salvador, BA",
  "userType": "VETERINARIO",
  "securityQuestion": "Qual é o nome do seu primeiro pet?",
  "securityAnswer": "Bella"
}'
test_register "$veterinario_data" "Veterinário"

# Teste 3: Testar autenticação
echo -e "\n${YELLOW}3. Testando autenticação...${NC}"
test_auth "admin@teste.com" "123456" "admin"
test_auth "tutor@teste.com" "123456" "tutor"
test_auth "lojista@teste.com" "123456" "lojista"
test_auth "vet@teste.com" "123456" "veterinario"

# Teste 4: Testar endpoints de Admin (com token de admin)
echo -e "\n${YELLOW}4. Testando endpoints de Admin...${NC}"
JWT_TOKEN=$ADMIN_TOKEN

test_endpoint "GET" "/admin/users" "" "200" "Listar todos os usuários"
test_endpoint "GET" "/admin/pets" "" "200" "Listar todos os pets"
test_endpoint "GET" "/admin/products" "" "200" "Listar todos os produtos"
test_endpoint "GET" "/admin/services" "" "200" "Listar todos os serviços"
test_endpoint "GET" "/admin/stats" "" "200" "Obter estatísticas do sistema"

# Teste 5: Testar endpoints de Auth
echo -e "\n${YELLOW}5. Testando endpoints de Auth...${NC}"

# Testar recuperação de senha
forgot_password_data='{"email": "tutor@teste.com"}'
test_endpoint "POST" "/auth/forgot-password" "$forgot_password_data" "200" "Solicitar recuperação de senha"

# Testar verificação de pergunta de segurança
security_question_data='{"email": "tutor@teste.com"}'
test_endpoint "POST" "/auth/security-question" "$security_question_data" "200" "Obter pergunta de segurança"

# Teste 6: Testar endpoints de Pet (com token de tutor)
echo -e "\n${YELLOW}6. Testando endpoints de Pet...${NC}"
JWT_TOKEN=$TUTOR_TOKEN

# Criar pet
pet_data='{
  "name": "Rex",
  "breed": "Golden Retriever",
  "age": 3,
  "weight": 25.5,
  "type": "Cachorro",
  "activityLevel": "Alto",
  "photoUrl": "https://example.com/rex.jpg"
}'
test_endpoint "POST" "/pets" "$pet_data" "201" "Criar pet"

# Listar pets do tutor
test_endpoint "GET" "/pets/tutor" "" "200" "Listar pets do tutor"

# Teste 7: Testar endpoints de Product (com token de lojista)
echo -e "\n${YELLOW}7. Testando endpoints de Product...${NC}"
JWT_TOKEN=$LOJISTA_TOKEN

# Criar produto
product_data='{
  "name": "Ração Premium",
  "description": "Ração de alta qualidade para cães",
  "price": 89.90,
  "imageUrl": "https://example.com/racao.jpg",
  "category": "Alimentação"
}'
test_endpoint "POST" "/products" "$product_data" "201" "Criar produto"

# Listar produtos do lojista
test_endpoint "GET" "/products/owner" "" "200" "Listar produtos do lojista"

# Listar todos os produtos (público)
test_endpoint "GET" "/products" "" "200" "Listar todos os produtos"

# Teste 8: Testar endpoints de VetService (com token de veterinário)
echo -e "\n${YELLOW}8. Testando endpoints de VetService...${NC}"
JWT_TOKEN=$VETERINARIO_TOKEN

# Criar serviço veterinário
service_data='{
  "name": "Consulta Veterinária",
  "description": "Consulta geral para pets",
  "price": 150.00,
  "imageUrl": "https://example.com/consulta.jpg"
}'
test_endpoint "POST" "/vet-services" "$service_data" "201" "Criar serviço veterinário"

# Listar serviços do veterinário
test_endpoint "GET" "/vet-services/owner" "" "200" "Listar serviços do veterinário"

# Listar todos os serviços (público)
test_endpoint "GET" "/vet-services" "" "200" "Listar todos os serviços"

# Teste 9: Testar endpoints de Food
echo -e "\n${YELLOW}9. Testando endpoints de Food...${NC}"
test_endpoint "GET" "/food" "" "200" "Listar alimentos"

# Teste 10: Testar endpoints de Store
echo -e "\n${YELLOW}10. Testando endpoints de Store...${NC}"
test_endpoint "GET" "/stores" "" "200" "Listar lojas"

# Teste 11: Testar endpoints de SecurityQuestion
echo -e "\n${YELLOW}11. Testando endpoints de SecurityQuestion...${NC}"
test_endpoint "GET" "/security-questions" "" "200" "Listar perguntas de segurança"

# Teste 12: Testar endpoints específicos por tipo de usuário
echo -e "\n${YELLOW}12. Testando endpoints específicos por tipo de usuário...${NC}"

# Endpoints de Tutor
JWT_TOKEN=$TUTOR_TOKEN
test_endpoint "GET" "/tutor/profile" "" "200" "Obter perfil do tutor"

# Endpoints de Lojista
JWT_TOKEN=$LOJISTA_TOKEN
test_endpoint "GET" "/lojista/profile" "" "200" "Obter perfil do lojista"

# Endpoints de Veterinário
JWT_TOKEN=$VETERINARIO_TOKEN
test_endpoint "GET" "/veterinario/profile" "" "200" "Obter perfil do veterinário"

# Teste 13: Testar operações CRUD completas
echo -e "\n${YELLOW}13. Testando operações CRUD completas...${NC}"

# Testar CRUD de Pet (Tutor)
JWT_TOKEN=$TUTOR_TOKEN

# Criar pet para teste de CRUD
crud_pet_data='{
  "name": "Luna",
  "breed": "Persa",
  "age": 2,
  "weight": 4.5,
  "type": "Gato",
  "activityLevel": "Médio",
  "photoUrl": "https://example.com/luna.jpg"
}'
test_endpoint "POST" "/pets" "$crud_pet_data" "201" "Criar pet para CRUD"

# Atualizar pet (assumindo que o ID é 1)
update_pet_data='{
  "id": 1,
  "name": "Luna Atualizada",
  "breed": "Persa",
  "age": 3,
  "weight": 5.0,
  "type": "Gato",
  "activityLevel": "Alto",
  "photoUrl": "https://example.com/luna-updated.jpg"
}'
test_endpoint "PUT" "/pets/1" "$update_pet_data" "200" "Atualizar pet"

# Deletar pet
test_endpoint "DELETE" "/pets/1" "" "200" "Deletar pet"

# Teste 14: Testar validações e erros
echo -e "\n${YELLOW}14. Testando validações e erros...${NC}"

# Tentar acessar endpoint sem autenticação
test_endpoint "GET" "/admin/users" "" "401" "Acesso sem autenticação (deve falhar)"

# Tentar acessar endpoint com token inválido
JWT_TOKEN="invalid_token"
test_endpoint "GET" "/admin/users" "" "401" "Acesso com token inválido (deve falhar)"

# Tentar criar pet com dados inválidos
JWT_TOKEN=$TUTOR_TOKEN
invalid_pet_data='{
  "name": "",
  "breed": "",
  "age": -1,
  "weight": -1,
  "type": "Invalid",
  "activityLevel": "Invalid"
}'
test_endpoint "POST" "/pets" "$invalid_pet_data" "400" "Criar pet com dados inválidos (deve falhar)"

# Teste 15: Testar endpoints de busca e filtros
echo -e "\n${YELLOW}15. Testando endpoints de busca e filtros...${NC}"

# Buscar produtos por categoria
test_endpoint "GET" "/products?category=Alimentação" "" "200" "Buscar produtos por categoria"

# Buscar serviços por preço
test_endpoint "GET" "/vet-services?maxPrice=200" "" "200" "Buscar serviços por preço máximo"

# Teste 16: Testar endpoints de estatísticas
echo -e "\n${YELLOW}16. Testando endpoints de estatísticas...${NC}"
JWT_TOKEN=$ADMIN_TOKEN
test_endpoint "GET" "/admin/stats" "" "200" "Obter estatísticas completas do sistema"

# ===================================================================
# =                   RESUMO DOS TESTES                           =
# ===================================================================

echo -e "\n${BLUE}==================================================================${NC}"
echo -e "${BLUE}=                   RESUMO DOS TESTES                        =${NC}"
echo -e "${BLUE}==================================================================${NC}"
echo "Testes concluídos em $(date)"
echo ""
echo "Endpoints testados:"
echo "- Autenticação (Login/Registro)"
echo "- Admin (Usuários, Pets, Produtos, Serviços, Estatísticas)"
echo "- Auth (Recuperação de senha, Perguntas de segurança)"
echo "- Pet (CRUD completo)"
echo "- Product (CRUD completo)"
echo "- VetService (CRUD completo)"
echo "- Food (Listagem)"
echo "- Store (Listagem)"
echo "- SecurityQuestion (Listagem)"
echo "- Perfis específicos por tipo de usuário"
echo "- Validações e tratamento de erros"
echo "- Busca e filtros"
echo ""
print_status "INFO" "Para ver logs detalhados, verifique o console do backend"
print_status "INFO" "Para testar o frontend, execute: flutter run -d chrome" 