FROM alpine:3.5
RUN apk --no-cache --update add apache2 apache2-utils php5-apache2 php5-xml php5-openssl php5-zlib openssl curl vim
RUN mkdir /run/apache2
ADD etc/apache2/conf.d/dokuwiki.conf /etc/apache2/conf.d
RUN sed -i.bak 's/\(apache:x\):\([[:digit:]]*\):\(.*\)/\1:20000:\3/g' /etc/passwd
RUN find -user 20000 -exec chown -h apache {} \;
RUN chown -R apache:apache /var/www/localhost/htdocs
ENTRYPOINT /usr/sbin/apachectl -D FOREGROUND
EXPOSE 80
