# wunder/fuzzy-alpine-php-fpm
#
# @TODO use these https://github.com/wunderkraut/docker-container-app-configs/tree/master/php
#    When ther are fixed.
#
# VERSION v7.1.5-0

FROM quay.io/wunder/fuzzy-alpine-base:v3.6
MAINTAINER james.nesbitt@wunder.io

####
# Install php7 packages from edge repositories
#
RUN apk --no-cache --update add \
        php7-fpm \
        php7-apcu \
        php7-common \
        php7-curl \
        php7-memcached \
        php7-xml \
        php7-xmlrpc \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-mysqlnd \
        php7-mysqli \
        php7-mcrypt \
        php7-opcache \
        php7-json \
        php7-pear \
        php7-mbstring \
        php7-soap \
        php7-ctype \
        php7-gd \
        php7-dom \
        php7-bcmath \
        php7-gmagick && \
    # Cleanup
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

####
# Add a www php-fpm service definition
#
ADD etc/php7/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf

####
# Add php settings and extension control from Wunder
#
ADD etc/php7/conf.d/90_wunder.ini /etc/php7/conf.d/90_wunder.ini

####
# Some default ENV values
#
ENV HOSTNAME phpfpm7
ENV ENVIRONMENT develop

####
# Add Drupal 8 specific folder structure so that it has correct permissions when it is volumized.
#
# @DEPRECATED based on use-case, this could be avoided.
#
# RUN mkdir -p /app/web/sites/default/files && \
# chown -R app:app /app

# Expose the php port
EXPOSE 9000

# Set php-fpm as the entrypoint
ENTRYPOINT ["/usr/sbin/php-fpm7", "--nodaemonize"]
