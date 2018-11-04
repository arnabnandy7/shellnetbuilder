rip=$1
bip=$2
dn=$3
dnip=$4
h=$5
hn=`echo $h.$dn`
sip=$6

#mac1=`ifconfig | grep -w "HWaddr"|cut -f2 -d ':'|cut -f4 -d ' '`
#mac2=`ifconfig | grep -w "HWaddr"|cut -f3 -d ':'`
#mac3=`ifconfig | grep -w "HWaddr"|cut -f4 -d ':'`
#mac4=`ifconfig | grep -w "HWaddr"|cut -f5 -d ':'`
#mac5=`ifconfig | grep -w "HWaddr"|cut -f6 -d ':'`
#mac6=`ifconfig | grep -w "HWaddr"|cut -f7 -d ':'`
#macaddr=`echo "$mac1:$mac2:$mac3:$mac4:$mac5:$mac6"`

macaddr=`ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'`

cp /etc/dhcp/dhcpd.conf /tmp/dhcp
	

a=`grep "option domain_name_server $sip;" /etc/dhcp/dhcpd.conf`
if [[ -z $a ]]
then
	echo "option domain_name_server $sip;" >> /etc/dhcp/dhcpd.conf
	echo "option router $rip;" >> /etc/dhcp/dhcpd.conf
	echo "option broadcast_address $bip;" >> /etc/dhcp/dhcpd.conf
	echo "option domain_search $dn;" >> /etc/dhcp/dhcpd.conf

	echo "host $h {" >> /etc/dhcp/dhcpd.conf
	echo "	option host_name \"$hn\";" >> /etc/dhcp/dhcpd.conf
	echo "	hardware ethernet $macaddr;" >> /etc/dhcp/dhcpd.conf
	echo "	fixed_address $sip;" >> /etc/dhcp/dhcpd.conf
	echo "}" >> /etc/dhcp/dhcpd.conf
fi

echo "The DHCP is updated for host "$hn>/etc/Network_Builder_V0.1/logs/DNS/dns-dhcpk.msg
echo "The DHCP is updated is successful">>/etc/Network_Builder_V0.1/logs/DNS/dns-dhcpk.msg
