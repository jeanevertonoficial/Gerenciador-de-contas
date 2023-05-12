# Base image
FROM php:8.1-fpm


# Instala dependências
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Limpa o cache do apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala as extensões do PHP necessárias
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instala o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cria o diretório de trabalho da aplicação
WORKDIR /var/www/html

# Copia os arquivos da aplicação para o contêiner
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev

# Copia o arquivo de configuração do Laravel
COPY .env.example .env

# Gera a chave de criptografia do Laravel
RUN php artisan key:generate

# Executa as migrations do Laravel
RUN php artisan migrate

# Expõe a porta 9000
EXPOSE 9000

# Inicia o servidor do PHP
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
