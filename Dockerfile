FROM arm32v7/alpine:latest

#ENV BIN_DIR /usr/local/bin
#ENV SBIN_DIR /usr/local/sbin

RUN adduser -D -u 1000 pi-star && adduser -D -u 1001 mmdvm && adduser -S www-data

RUN apk add --update --no-cache g++ nginx php-fpm \
	cmake make git linux-headers

RUN git clone https://github.com/g4klx/MMDVMHost.git \
	&& cd MMDVMHost \
	&& make all \
	&& cp MMDVMHost RemoteCommand /usr/local/bin/ \
	&& cd .. \ 
	&& rm -rf MMDVMHost

RUN git clone https://github.com/g4klx/YSFClients.git \
	&& cd YSFClients/YSFGateway/ \
	&& make all \
	&& cp YSFGateway /usr/local/bin/ \
	&& cd ../YSFParrot \
	&& make \
	&& cp YSFParrot /usr/local/bin/ \
	&& cd ../.. \
	&& rm -rf YSFClients


#COPY Pi-Star_DV_Dash /var/www/dashboard
RUN cd /var/www \
	&& git clone https://github.com/ian-droid/Pi-Star_Docker_Dash.git dashboard \
	&& rm dashboard/.git -rf

#RUN mkdir -p /run/nginx /run/php
COPY pistar-release /etc/
COPY nginx.conf /etc/nginx/
COPY php-fpm.conf /etc/php7/
COPY start.sh /bin/

#COPY Pi-Star_v4_Binaries_Bin /usr/local/bin
#COPY Pi-Star_Binaries_sbin /usr/local/sbin


RUN apk del cmake make git linux-headers\
	&& rm -rf /var/cache/apk/*

EXPOSE 80

VOLUME ["/var/log/", "/usr/local/etc/", "/var/www/dashboard/"]

ENTRYPOINT ["/bin/sh", "/bin/start.sh"]
