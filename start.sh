#!/bin/bash

# Buildar o composer
docker-compose build

# Inicia o contêiner do Docker Compose
docker-compose up -d

#build do vue
npm run build

# Aguarda alguns segundos para que o Nginx inicie completamente
sleep 5

# Abre a aplicação Vue.js no navegador padrão
open http://localhost:8081