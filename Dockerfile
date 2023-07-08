FROM php:8.2.7-fpm-bullseye
RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libmemcached-dev \
		libssl-dev \
		zlib1g-dev
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd
	&& docker-php-ext-enable json
	&& docker-php-ext-enable zip
	&& docker-php-ext-enable zlib
	&& docker-php-ext-enable pdo_mysql
	&& docker-php-ext-enable bz2
	&& docker-php-ext-enable ldap
	&& docker-php-ext-enable smbclient
	&& docker-php-ext-enable ftp
	&& docker-php-ext-enable imap
	&& docker-php-ext-enable bcmath
	&& docker-php-ext-enable gmp
	&& docker-php-ext-enable exif
	&& docker-php-ext-enable apcu
	&& docker-php-ext-enable memcached
	&& docker-php-ext-enable redis