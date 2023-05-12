#!/bin/bash

# Buildar o composer
docker-compose up -d --build

# Inicia o contêiner do Docker Compose
docker-compose up -d mysql nginx

# Inicia o php Artisan
docker-compose exec backend php artisan migrate

# Aguarda alguns segundos para que os serviços iniciem completamente
sleep 5

# Executa os comandos de build e serve do Vue
npm run build
npm run serve

# Executa as migrations do Laravel
cd backend
php artisan migrate

# Abre a aplicação Vue.js no navegador padrão
open http://localhost:8081