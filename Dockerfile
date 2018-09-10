FROM debian:latest

# install apache and mod_php
RUN apt-get update \
  && apt-get -y install vim libapache2-mod-php \
  && rm -rf /var/lib/apt/lists/*

# install TYPO3 Requirements
# see https://docs.typo3.org/typo3cms/InstallationGuide/In-depth/SystemRequirements/Index.html
RUN apt-get update \
 && apt-get -y install mysql-client php-mysql curl zip unzip php-xml less php-gd php-zip \
 && phpenmod xml gd zip \
 && rm -rf /var/lib/apt/lists/*

# Required TYPO3 PHP Settings
COPY php/apache/php.ini /etc/php/7.0/apache2/conf.d/99-typo3.ini

# install PHP composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# allow su to www-data
RUN chsh -s /bin/bash www-data ; chown www-data /var/www -R ; mkdir -p /var/www/bin

VOLUME /var/www
RUN apt-get update \
  && apt-get install rsync -y \
  && rm -rf /var/lib/apt/lists/*
COPY /init.sh /
CMD /init.sh

# Install latest TYPO3
ENV TYPO3_DISTRIBUTION typo3/cms-base-distribution:8.7
COPY install-typo3.sh /var/www/bin/install-typo3.sh

RUN apt-get update \
  && apt-get install sudo \
  && mkdir -p /var/www-orig/html && chown www-data -R /var/www-orig \
  && sudo -u www-data /var/www/bin/install-typo3.sh ${TYPO3_DISTRIBUTION} /var/www-orig/html \
  && rm -rf /var/lib/apt/lists/*

# Configure apache web root
COPY configure-apache.sh /
RUN /configure-apache.sh
