# Usa a imagem oficial do PHP com Apache
FROM php:8.3-apache

# Instala extensões necessárias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia os arquivos do projeto para dentro do container
WORKDIR /var/www/html
COPY . .

# Dá permissão para a pasta storage e bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Instala as dependências do Laravel
RUN composer install

# Gera a chave da aplicação
RUN php artisan key:generate

# Expõe a porta 80 para acessar a aplicação
EXPOSE 80

# Comando de inicialização
CMD ["apache2-foreground"]
