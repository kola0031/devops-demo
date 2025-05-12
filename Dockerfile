FROM php:8.1-apache

# Install required tools and PHP extensions
RUN apt-get update && apt-get install -y \
    gettext \
    unzip \
 && docker-php-ext-install mysqli \
 && a2enmod rewrite

# Copy web files and configs
COPY ./webapp/ /var/www/html/
COPY webapp/config-template.ini /var/www/html/config-template.ini
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Set permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Optional Apache config
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf && a2enconf servername

# Entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
# Expose port 80
EXPOSE 80