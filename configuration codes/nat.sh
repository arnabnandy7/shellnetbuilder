#################################################################
#								#
# 		    NAT server configuration			#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Network_Builder_V0.1/logs/NAT/natk.msg
else
	echo "Administrative privilage required, unless the application will not work.">/etc/Network_Builder_V0.1/logs/NAT/natk.msg
	echo "So NAT configuration is not possible, please login with root privilage.">>/etc/Network_Builder_V0.1/logs/NAT/natk.msg
	exit
fi


sysctl -w net.ipv4.ip_forward=1>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg

sysctl -p /etc/sysctl.conf>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg

temp=`iptables -t nat -L POSTROUTING|grep MASQUERADE`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
fi

service iptables save>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg
