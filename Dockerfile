# wunder/fuzzy-alpine-php
#
# VERSION v7.0.12-0

FROM quay.io/wunder/fuzzy-alpine-base:v3.4
MAINTAINER aleksi.johansson@wunder.io

# Install php7 packages from edge repositories.
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk --no-cache --update add \
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

# Expose the php port.
EXPOSE 9000

# Set php-fpm as the entrypoint.
ENTRYPOINT ["/usr/sbin/php-fpm7", "--nodaemonize"]
