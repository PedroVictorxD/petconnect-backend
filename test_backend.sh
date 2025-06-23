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
response=$(curl -s -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$admin_data" "$BASE_URL/api/auth/register")

login_data='{"email":"admin@teste.com","password":"123456"}'
response=$(curl -s -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$login_data" "$BASE_URL/api/auth/login")

response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $JWT_TOKEN" "$BASE_URL/api/admin/users")

response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $JWT_TOKEN" "$BASE_URL/api/admin/pets")

response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $JWT_TOKEN" "$BASE_URL/api/admin/stats")

response=$(curl -s -w "%{http_code}" "$BASE_URL/api/products")

response=$(curl -s -w "%{http_code}" "$BASE_URL/api/vet-services")

response=$(curl -s -w "%{http_code}" "$BASE_URL/api/food")

forgot_data='{"email":"admin@teste.com"}'
response=$(curl -s -w "%{http_code}" -X POST -H "Content-Type: application/json" -d "$forgot_data" "$BASE_URL/api/auth/forgot-password") 