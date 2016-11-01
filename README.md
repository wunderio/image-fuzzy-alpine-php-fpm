# alpine-php

A base docker image for php applications, on which other application speficif (like Drupal) images can be base, in order to share a set of standards.

Maintained by: James Nesbitt <james.nesbitt@wunder.io>

## Docker

### Image

This image is available publicly at:

- quay.io/wunder/alpine-php : [![Docker Repository on Quay](https://quay.io/repository/wunder/alpine-php/status "Docker Repository on Quay")](https://quay.io/repository/wunder/alpine-php)

### Base

This image is based on https://github.com/wunderkraut/alpine-base

### Modifications

#### Install php

1. Install php-fpm (no cli)
2. Include a large number of common php extensions
3. Set the image to run and expose php-fpm as a service at port 9000

## Using this Image

run this container as an independent service:

```
$/> docker run -d quay.io/wunder/alpine-php
```

map any needed services such as memcache and dbs, and mount any source code volumes to whatever path needed:

```
$/> docker run -d \
      -v "$(pwd):/app/web" \
      -l "my_running_db_container:db.app" \
      -l "my_running_redis_container:redis.app" ''
      quay.io/wunder/alpine-php
```

## TODO

1. some kind of automated testing would be usefull.
