FROM alpine:latest
RUN apk --no-cache --update add apache2 apache2-utils php5-apache2 php5-xml php5-openssl openssl curl
RUN	mkdir /run/apache2
ADD etc/apache2/conf.d/dokuwiki.conf /etc/apache2/conf.d
RUN chown -R apache:apache /var/www/localhost/htdocs
ENTRYPOINT /usr/sbin/apachectl -D FOREGROUND
EXPOSE 80
