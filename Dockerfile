FROM quay.io/wunder/alpine-base:v3.4
MAINTAINER aleksi.johansson@wunder.io

# Install php7 packages from edge repositories.
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
apk --no-cache --update add \
    php7 \
    php7-common \
    php7-curl \
    # php7-memcached \
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
    php7-fpm \
    php7-pear \
    php7-mbstring \
    php7-soap \
    php7-ctype \
    php7-gd \
    php7-dom \
    php7-bcmath \
    php7-gmagick && \
# Build php7-memcached from source instead of adding with apk above
# since it's not currently availabe.
# See https://github.com/alpinelinux/aports/pull/286 for status.
# Add build dependencies.
apk add --no-cache tar sed grep curl wget gzip pcre ca-certificates \
    build-base zlib-dev autoconf libmemcached-dev \
    php7-dev php7-session && \
# Fetch the php7-memcached source and build/install/cleanup
curl -o php7-memcached.tar.gz -SL https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz && \
tar -xzf php7-memcached.tar.gz && \
cd php-memcached-php7 && \
phpize7 && \
./configure --prefix=/usr --disable-memcached-sasl --with-php-config=php-config7 && \
make && \
make install && \
install -d /etc/php7/conf.d && \
echo "extension=memcached.so" > /etc/php7/conf.d/20_memcached.ini && \
cd .. && \
rm -rf php7-memcached.tar.gz && \
rm -rf php-memcached-php7 && \
# Prune the build deps for php7-memcached
apk del build-base zlib-dev autoconf libmemcached-dev php7-dev && \
# Cleanup
rm -rf /tmp/* && \
rm -rf /var/cache/apk/*

# Expose the php port.
EXPOSE 9000

# Set php-fpm as the entrypoint.
ENTRYPOINT ["/usr/sbin/php-fpm7", "--nodaemonize"]
