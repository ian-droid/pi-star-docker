This is a preliminary Dockerfile used to build Pi-Star image for running on ARM SBC with docker supported OS.
Currently, it only supports basic DMR and YSF functionality.

## Tested Device and OS
* Raspberry Pi 3 Model B+
* MMDVM HS Dual Hat (v1.3.6)
* Debian 10.02 'Buster' Arm64 (4.19.0-6-arm64)
* Docker CE 19.03.5 

## Volumes
Two volumes need to be mapped into container:
* /usr/local/etc/ - where all the configuration files go.
* /var/log/ - holds all the logs, need to be writeable for uid 1000 and 1001.

## Files
It's using a modified Pi-Star [dashboard](https://github.com/ian-droid/Pi-Star_Docker_Dash), to make it run properly, most of the config files in /etc of pi-star need to be copied into the config volume:
* DMRIds.dat
* DMR_Hosts.txt
* RSSI.dat
* YSFHosts.txt
* dapnetgateway
* dmr2nxdn
* dmr2ysf
* dmrgateway
* dstar-radio.mmdvmhost
* htpasswd
* ircddbgateway
* mmdvmhost
* nxdngateway
* p25gateway
* wpa_supplicant.conf
* ysf2dmr
* ysf2nxdn
* ysf2p25
* ysfgateway

## Command
> docker run -d -p 80:80 --device /dev/ttyS1:/dev/ttyAMA0 -v /home/ian/Pi-Star/log/:/var/log/ -v /home/ian/Pi-Star/conf/:/usr/local/etc/ -v /home/ian/Pi-Star/pi-star-docker/Pi-Star_Docker_Dash/:/var/www/dashboard/ pi-star-docker:arm32v7

_*/dev/ttyS1*_ is the device name of MMDVM modem under Debian (mini UART, you may need to disable BT to use it on RPi3)
