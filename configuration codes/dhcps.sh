a=`service dhcpd stop|grep OK`

if [[ -z $a ]]
then
	echo "DHCP Status: Stopped">/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.status
else
	echo "DHCP Status: Running">/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.status
	service dhcpd start>>/dev/null
fi
