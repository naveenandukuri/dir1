FROM alpine
MAINTAINER naveen@gmail.com
RUN apk install -y java
RUN apk install -y httpd \
zip\
unzip
CMD /bin/bash
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic.zip photogenic
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
EXPOSE 80
