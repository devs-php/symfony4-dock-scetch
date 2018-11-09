FROM php:7.2-fpm-stretch

RUN set -x \
    && useradd -m -U -u 1000 devsphp \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
        libfontconfig1 \
        libssl1.0-dev \
        libxext6 \
        libxrender1 \
        libzip-dev \
        nodejs \
        wget \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)"\
        pdo_mysql \
        zip \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* \
    # install Yarn
    && wget https://github.com/yarnpkg/yarn/releases/download/v1.10.1/yarn_1.10.1_all.deb \
    && dpkg -i yarn_1.10.1_all.deb \
    && rm yarn_1.10.1_all.deb

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY ./docker/php/php.ini /usr/local/etc/php/

USER devsphp

RUN composer global require hirak/prestissimo

WORKDIR /app
