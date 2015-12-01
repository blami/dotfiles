#!/bin/sh
# ~/.screenrc/ip.sh: Print internet interface IP

# TODO Solaris
if [ ! -x /bin/ip ] ; then
	echo -
	exit 1
fi

INET_IFACE=$(/bin/ip route \
	| awk '/^default/ {for(i=1;i<NF;i++) if($i=="dev") print $(NF),$(i+1)}' \
	| sort -n | head -1 | cut -d' ' -f2)
INET_IP=$(ip -f inet addr show $INET_IFACE \
	| grep -Po 'inet \K[\d.]+')

echo $INET_IFACE:$INET_IP

