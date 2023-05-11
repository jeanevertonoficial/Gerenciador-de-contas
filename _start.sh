#!/bin/bash

# Buildar o composer
docker-compose build

# Inicia o contêiner do Docker Compose
docker-compose up -d mysql nginx

# Aguarda alguns segundos para que os serviços iniciem completamente
sleep 10

# Executa os comandos de build e serve do Vue
npm run build
npm run serve

# Abre a aplicação Vue.js no navegador padrão
open http://localhost:8081