#!/bin/bash
set -e

# Generate config.ini from the template using environment variables
envsubst < /var/www/html/config-template.ini > /var/www/html/config.ini

# Start Apache in the foreground
exec apache2-foreground
