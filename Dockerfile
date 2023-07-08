FROM php:8.2.7-fpm-bullseye
ENV PHP_EXTRA_CONFIGURE_ARGS="--with-apxs2 --with-zip --with-zlib --with-pdo-mysql --with-ldap --enable-ftp --with-imap --with-gmp --enable-exif --enable-bcmath --with-openssl"
RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libmemcached-dev \
		libssl-dev \
		libldap2-dev \
		libftp-dev \
		zlib1g-dev \
		libsmbclient-dev \
		libzip-dev \
		libgmp-dev \
    && pecl install memcached-3.2.0 redis-5.3.7 smbclient-1.1.1 \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-enable memcached redis \
	&& docker-php-ext-configure pdo_mysql --host=x86_64\
	&& docker-php-ext-install -j$(nproc) pdo_mysql \
	&& docker-php-ext-configure imap --host=x86_64\
	&& docker-php-ext-install -j$(nproc) imap 