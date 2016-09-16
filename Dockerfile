FROM quay.io/wunder/alpine-base:v3.4
MAINTAINER aleksi.johansson@wunder.io

# Update the package repository and install applications
RUN echo http://dl-cdn.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories && \
apk --no-cache --update add \
    php \
    php-common \
    php-memcache \
    php-xml \
    php-xmlrpc \
    php-pdo \
    php-mysql \
    php-mcrypt \
    php-opcache \
    php-json \
    php-fpm \
    php-pear \
    php-soap && \
rm -rf /tmp/* && \
rm -rf /var/cache/apk/*

EXPOSE 9000

ENTRYPOINT ["/usr/bin/php-fpm", "--nodaemonize"]
