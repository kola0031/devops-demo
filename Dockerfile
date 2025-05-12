FROM php:8.1-apache

# Install mysqli and unzip
RUN docker-php-ext-install mysqli

# Enable Apache rewrite
RUN a2enmod rewrite

# Copy app code
COPY ./webapp/ /var/www/html/

# Copy template config
COPY config-template.ini /var/www/html/config.ini

# Optional: for better dev visibility
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf && a2enconf servername

# Copy app files and template
COPY ./ /var/www/html/
COPY config-template.ini /var/www/html/config-template.ini
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Use custom entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]