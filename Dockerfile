# Estágio de construção
FROM node:14 AS builder

# Diretório de trabalho
WORKDIR /app

# Copia o package.json e package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instala as dependências do projeto, incluindo o npm
RUN apt-get update && apt-get install -y npm
RUN npm install

# Copia todos os arquivos do projeto para o diretório de trabalho
COPY . .

# Compila o projeto Vue.js para produção
RUN npm run build

# Estágio final
FROM nginx:1.21

# Copia o arquivo de configuração do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia os arquivos compilados do projeto Vue.js para o diretório do Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 81

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]