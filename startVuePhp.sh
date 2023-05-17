#!/bin/bash

# Executa os comandos de build e serve do Vue
npm run build
npm run serve

# Executa as migrations do Laravel
cd backend
php artisan migrate
