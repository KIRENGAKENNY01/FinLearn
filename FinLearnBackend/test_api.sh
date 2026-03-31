#!/bin/bash

BASE_URL="http://10.12.73.138:8081/api/v1"
TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ4Mjg5MmZhMzJlY2QxM2E0ZTBhZWZlNjI4ZGQ5YWFlM2FiYThlMWUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmlubGVhcm4tODI4NDkiLCJhdWQiOiJmaW5sZWFybi04Mjg0OSIsImF1dGhfdGltZSI6MTc2Nzg5NjQxOCwidXNlcl9pZCI6InF0akxPRTlnbklmMDUydlZhaDVxRFAzSHhRSzIiLCJzdWIiOiJxdGpMT0U5Z25JZjA1MnZWYWg1cURQM0h4UUsyIiwiaWF0IjoxNzY3ODk2NDE4LCJleHAiOjE3Njc5MDAwMTgsImVtYWlsIjoidGVzdHVzZXJAZXhhbXBsZS5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsidGVzdHVzZXJAZXhhbXBsZS5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.jG7OBXhARBNhCPDM7LRzhjW28xVcqRjTNMjgK76kT3rzc-ZMHqh9SbH9Dv98RNyYGLr8WvkLio67SDC5CEvIelyaAB03VuZlm42Xj-lczr44yMbkpiC0E6gXI8nZvKYG2og4X8V1cKttLVoUJ1SVF7TFgFfSmojr7JShGeAAUgtwzvANnzOx0Dt9ilj3uu67HR5f9kK4XCkElHvpwU7Ed0FluZEt2cKJijSBb-wbZWmMp11pS2nqoaQOzLFL-loOUZfJLMXQq5ZoDCOeL7O-jdXmnad7GGsFDGvayh0k4R1L7Fjinhr2Ej55BTfIszd6AgHGxo5CO1KZL8y1pDzNRg"

echo "🧪 Testing Budget Followup..."
curl -s -X POST "$BASE_URL/budget/followup" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "plan": { "userId": "u1", "monthIso": "2025-11", "totalPlannedIncome": 1000000, "totalPlannedExpenses": 500000, "currency": "RWF" },
    "actualIncome": 1050000, "actualExpenses": 550000,
    "emergencies": [{ "title": "Medical", "amount": 50000 }]
}' | json_pp
echo "\n"

echo "🧪 Testing Loan Calculator..."
curl -s -X POST "$BASE_URL/loan/calculate" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "amount": 500000, "rate": 5.0, "months": 12 }' | json_pp
echo "\n"

echo "🧪 Testing Savings Evaluation..."
curl -s -X POST "$BASE_URL/savings/evaluate" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "expectedSavings": 200000, "actualIncome": 1000000, "actualExpenses": 800000, "emergencies": [{ "title": "Repair", "amount": 50000 }] }' | json_pp
echo "\n"

echo "🧪 Testing Learning Progress..."
curl -s -X GET "$BASE_URL/learning/progress" \
  -H "Authorization: Bearer $TOKEN" | json_pp
echo "\n"

echo "🧪 Testing User Persistence..."
# 1. Create User
echo "Creating User..."
curl -s -X POST "$BASE_URL/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "qtjLOE9gnIf052vVah5qDP3HxQK2",
    "email": "testuser@example.com",
    "displayName": "Kenny",
    "totalPoints": 0,
    "currentLevel": "Beginner"
}' 
echo "\n"

# 2. Get User
echo "Getting User..."
curl -s -X GET "$BASE_URL/users/me" \
  -H "Authorization: Bearer $TOKEN" | json_pp
echo "\n"
