# Usa a imagem do PHP com FPM
FROM php:8.2-fpm

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql gd

# Instala o Composer dentro do container
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho dentro do container
WORKDIR /var/www

# Copia os arquivos do Laravel para dentro do container
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Define permissões para o Laravel funcionar corretamente
RUN chmod -R 775 storage bootstrap/cache

# Exibe a porta onde o container estará rodando
EXPOSE 9000
# Usa a imagem do PHP com FPM
FROM php:8.2-fpm

# Instala extensões necessárias para o Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql gd

# Instala o Composer dentro do container
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho dentro do container
WORKDIR /var/www

# Copia os arquivos do Laravel para dentro do container
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Define permissões para o Laravel funcionar corretamente
RUN chmod -R 775 storage bootstrap/cache

# Define a porta onde o container escutará conexões
EXPOSE 9000
