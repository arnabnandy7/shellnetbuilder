#################################################################
#								#
# 		    DHCP server configuration			#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg
else
	echo "Administrative privilege required, unless the application will not work.">/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg
	echo " " >> /etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg
	echo "So DHCP configuration is not possible, please login with root privilege." >> /etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg
	exit
fi

q=`wc -l /etc/rsyslog.conf|cut -f1 -d ' '`
f=1
for (( i=1; i<=$q; i++ ))
do
	a=`head -$i /etc/rsyslog.conf |tail -1|egrep "local6.*/var/log/dhcp.log"`	
	if [[ ! -z $a ]]
	then
		f=0
		break;
	fi
	a=`head -$i /etc/rsyslog.conf |tail -1|egrep "/var/log/dhcp.log"`	
	if [[ ! -z $a ]]
	then
		f=0
		break;
	fi
done
if [[ f -eq 1 ]]
then
	echo "local6.*                                                /var/log/dhcp.log">>/etc/rsyslog.conf
fi

#yum install dhcp*
echo "The dhcp package is installed.">>/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg

nic=$1
sip=$2
sub=$3
ntm=$4
gtway=$5
lr=$6
ur=$7

echo "DEVICE=eth0" >/etc/sysconfig/network-scripts/ifcfg-dhcp
echo "BOOTPROTO=static" >>/etc/sysconfig/network-scripts/ifcfg-dhcp
echo "ONBOOT=yes" >>/etc/sysconfig/network-scripts/ifcfg-dhcp
echo "IPADDR=$sip" >>/etc/sysconfig/network-scripts/ifcfg-dhcp
echo "NETMASK=$ntm" >>/etc/sysconfig/network-scripts/ifcfg-dhcp
echo "GATEWAY=$gtway" >>/etc/sysconfig/network-scripts/ifcfg-dhcp

ifconfig eth0 $sip netmask $ntm

if [[ ! -f /var/log/dhcp.log ]]
then
	touch /var/log/dhcp.log
fi

ifup dhcp>>/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg

temp=`grep authoritative /etc/dhcp/dhcpd.conf`

if [[ -z $temp ]]
then
	echo "default-lease-time 600;">/etc/dhcp/dhcpd.conf
	echo "max-lease-time 7200;">>/etc/dhcp/dhcpd.conf
	echo "authoritative;">>/etc/dhcp/dhcpd.conf
	echo "log-facility local6;">>/etc/dhcp/dhcpd.conf
	echo "subnet $sub netmask $ntm {range $lr $ur;}">>/etc/dhcp/dhcpd.conf
else
	t=`grep "subnet $sub netmask $ntm {range $lr $ur;}" /etc/dhcp/dhcpd.conf`	
	if [[ -z $t ]]
	then
		cp /etc/dhcp/dhcpd.conf /tmp/dhcp
		rm -f /etc/dhcp/dhcpd.conf
		touch /etc/dhcp/dhcpd.conf
		q=`wc -l /tmp/dhcp|cut -f1 -d ' '`

		for (( i=1; i<=$q; i++ ))
		do
			fl=0
			a=`head -$i /tmp/dhcp |tail -1`
			head -$i /tmp/dhcp |tail -1 > /tmp/ext
			temp=`grep "range" /tmp/ext`
			if [[ -n $temp ]]
			then
				echo "subnet $sub netmask $ntm {range $lr $ur;}">>/etc/dhcp/dhcpd.conf
				fl=1
			fi
			if [[ fl -ne 1 ]]
			then
				 head -$i /tmp/dhcp |tail -1 >> /etc/dhcp/dhcpd.conf
			fi
		done
	fi
fi

rm -f /tmp/dhcp /tmp/ext

ifup dhcp>>/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg

service dhcpd restart>>/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg

chkconfig dhcpd on

chkconfig --list dhcpd>>/etc/Network_Builder_V0.1/logs/DHCP/dhcpk.msg


