# image-fuzzy-alpine-php-fpm

Fuzzy as in reference to the https://en.wikipedia.org/wiki/The_Mythical_Man-Month book where Fred describes the approach of "write one to throw away" as the best start.

A base docker image for php applications, on which other application speficif (like Drupal) images can be base, in order to share a set of standards.

Maintained by: James Nesbitt <james.nesbitt@wunder.io>

## Docker

### Image

This image is available publicly at:

- quay.io/wunder/fuzzy-alpine-php-fpm : [![Docker Repository on Quay](https://quay.io/repository/wunder/fuzzy-alpine-php-fpm/status "Docker Repository on Quay")](https://quay.io/repository/wunder/fuzzy-alpine-php-fpm)

### Base

This image is based on https://github.com/wunderkraut/image-fuzzy-alpine-base.

### Modifications

#### Install php

1. Install php-fpm (no cli)
2. Include a large number of common php extensions
3. Set the image to run and expose php-fpm as a service at port 9000

#### /etc/php7/php-fpm.d/www.conf

This is a custom fpm configuration:

1. runs as app:app;
2. listens as app:app on port 9000;
3. sets a run/nice mode (pm.ondemand);
4. enable status and ping paths;
5. rewires logging to output to the docker container output;
6. log all errors, but don't display any errors (standard production).

#### /etc/php7/conf.d/90_wunder.ini

1. increase the default limits for memory usage, cache, and execution time;
2. increate the default limits for post and file uploads;
3. turns off error output to response
4. default to UTC
5. enable opcache

## Using this Image

run this container as an independent service:

```
$/> docker run -d quay.io/wunder/fuzzy-alpine-php-fpm
```

map any needed services such as memcache and dbs, and mount any source code volumes to whatever path needed:

```
$/> docker run -d \
      -v "$(pwd):/app/web" \
      -l "my_running_db_container:db.app" \
      -l "my_running_redis_container:redis.app" ''
      quay.io/wunder/fuzzy-alpine-php-fpm
```

## TODO

1. some kind of automated testing would be usefull.
