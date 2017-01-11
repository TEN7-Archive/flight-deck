FROM alpine
MAINTAINER tess@ten7.com

# Install Apache and PHP.
RUN apk add --update --no-cache \
            php7 \
            git \
            curl \
            php7-curl \
            php7-mcrypt \
            php7-json \
            php7-phar \
            php7-openssl \
            php7-dom \
            php7-mbstring \
            php7-xml \
            php7-ctype \
            php7-opcache \
            php7-zlib \
            php7-zip \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Add and chmod our run scripts.
COPY run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 8000

WORKDIR /var/www/html

CMD ["/scripts/run.sh"]
