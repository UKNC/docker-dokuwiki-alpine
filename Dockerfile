FROM alpine:latest
RUN apk --no-cache --update add apache2 apache2-utils php5-apache2 php5-xml php5-openssl openssl curl
RUN	mkdir /run/apache2
#RUN cd /var/www/localhost/htdocs; \
#		curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | tar xvz --strip-components 1; \
ADD etc/apache2/conf.d/dokuwiki.conf /etc/apache2/conf.d
ADD wiki.tgz /var/www/localhost/htdocs/
RUN chown -R apache:apache /var/www/localhost/htdocs
ENTRYPOINT /usr/sbin/apachectl -D FOREGROUND
EXPOSE 80
