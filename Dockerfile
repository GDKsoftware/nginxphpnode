FROM php:5.6

RUN \
  apt-get update && \
  apt-get install -y python-software-properties software-properties-common wget zip unzip zlib1g-dev curl && \
  add-apt-repository -y ppa:nginx/stable && \
  docker-php-ext-install mysql && \
  docker-php-ext-install mysqli && \
  docker-php-ext-install pdo_mysql && \
  docker-php-ext-install zip && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
