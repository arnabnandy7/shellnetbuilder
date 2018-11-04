#################################################################
#								#
# 		    HTTP server configuration			#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg
else
	echo "Administrative privilage required, unless the application will not work.">/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg
	echo "So HTTP configuration is not possible, please login with root privilage.">>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg
	exit
fi

a=`rpm -qa|grep -w httpd|wc -l`

#yum install httpd

echo "httpd package are installed in system.">>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg

sip=$1
dirin=$2
pp=$3

srvnm=$5
cons=$6
dirh=$4

if [[ -f $cons ]]
then
	cp $cons /var/www/html/
	tar -xvf /var/www/html/$cons
else
	echo "The compressed website file is not found.">>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg
fi

cp $pp/$dirin /var/www/html/


mkdir /var/www/html/$dirh

if [[ -z $srvnm ]]
then
	echo "<VirtualHost *:80>" >> /etc/httpd/conf/httpd.conf
	echo "	ServerAdmin root@$sip" >> /etc/httpd/conf/httpd.conf
	echo "	DocumentRoot /var/www/html" >> /etc/httpd/conf/httpd.conf
	echo "	DirectoryIndex $dirin" >> /etc/httpd/conf/httpd.conf
	echo "	ServerName $dirh" >> /etc/httpd/conf/httpd.conf
	echo "</VirtualHost>" >> /etc/httpd/conf/httpd.conf
else
	echo "<VirtualHost *:80>" >> /etc/httpd/conf/httpd.conf
	echo "	ServerAdmin root@$sip" >> /etc/httpd/conf/httpd.conf
	echo "	DocumentRoot /var/www/html" >> /etc/httpd/conf/httpd.conf
	echo "	DirectoryIndex $dirin" >> /etc/httpd/conf/httpd.conf
	echo "	ServerName $srvnm" >> /etc/httpd/conf/httpd.conf
	echo "	<Directory \"/var/www/html/$dirh\">" >> /etc/httpd/conf/httpd.conf
	echo "		Options Indexes" >> /etc/httpd/conf/httpd.conf
	echo "		Order Allow,Deny" >> /etc/httpd/conf/httpd.conf
	echo "		Allow from all" >> /etc/httpd/conf/httpd.conf
	echo "	</Directory>" >> /etc/httpd/conf/httpd.conf
	echo "</VirtualHost>" >> /etc/httpd/conf/httpd.conf
fi


httpd -t

temp=`iptables -L INPUT|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D INPUT -j REJECT --reject-with icmp-host-prohibited
fi

temp=`iptables -L INPUT|grep "tcp dpt:http"`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
fi

temp=`iptables -L FORWARD|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D FORWARD -j REJECT --reject-with icmp-host-prohibited
fi

service iptables save>>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg

service httpd restart>>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg

chkconfig httpd on

chkconfig --list httpd>>/etc/Network_Builder_V0.1/logs/HTTP/httpk.msg
