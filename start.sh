#/bin/sh
php-fpm7
nginx
/usr/local/bin/YSFGateway /usr/local/etc/ysfgateway &
/usr/local/bin/YSFParrot 42012 &
/usr/local/bin/MMDVMHost /usr/local/etc/mmdvmhost
