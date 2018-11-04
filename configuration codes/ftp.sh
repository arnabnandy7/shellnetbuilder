#################################################################
#								#
# 		    FTP server configuration			#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Network_Builder_V0.1/logs/NAT/natk.msg
else
	echo "Administrative privilage required, unless the application will not work.">/etc/Network_Builder_V0.1/logs/NAT/natk.msg
	echo "So FTP configuration is not possible, please login with root privilage.">>/etc/Network_Builder_V0.1/logs/NAT/natk.msg
	exit
fi

#yum install vsftpd

fl=$1

if [[ -d $fl ]]
then
	mv $fl /var/ftp/pub
fi
if [[ -f $fl ]]
then
	cp $fl /var/ftp/pub
	tmp=`echo $fl|grep "zip"`
	if [[ ! -z $tmp ]]
	then
		unzip /var/ftp/pub/$fl
	else
		tar -xvf /var/ftp/pub/$fl
	fi
fi

echo "vsftpd package are installed in system.">>/etc/Network_Builder_V0.1/logs/NAT/natk.msg

a=`getsebool -a|grep allow_ftpd_anon_write|grep on`
if [[ -z $a ]]
then
	setsebool -P allow_ftpd_anon_write on
fi
a=`getsebool -a|grep allow_ftpd_full_access|grep on`
if [[ -z $a ]]
then
	setsebool -P allow_ftpd_full_access on
fi
a=`getsebool -a|grep allow_ftpd_use_cifs|grep on`
if [[ -z $a ]]
then
	setsebool -P allow_ftpd_use_cifs on
fi
a=`getsebool -a|grep allow_ftpd_use_nfs|grep on`
if [[ -z $a ]]
then
	setsebool -P allow_ftpd_use_nfs on
fi
a=`getsebool -a|grep ftp_home_dir|grep on`
if [[ -z $a ]]
then
	setsebool -P ftp_home_dir on
fi
a=`getsebool -a|grep ftpd_connect_db|grep on`
if [[ -z $a ]]
then
	setsebool -P ftpd_connect_db on
fi
a=`getsebool -a|grep ftpd_use_passive_mode|grep on`
if [[ -z $a ]]
then
	setsebool -P ftpd_use_passive_mode on
fi
a=`getsebool -a|grep httpd_enable_ftp_server|grep on`
if [[ -z $a ]]
then
	setsebool -P httpd_enable_ftp_server on
fi
a=`getsebool -a|grep tftp_anon_write|grep on`
if [[ -z $a ]]
then
	setsebool -P tftp_anon_write on
fi

temp=`iptables -L INPUT|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D INPUT -j REJECT --reject-with icmp-host-prohibited
fi

temp=`iptables -L INPUT|grep "tcp dpt:ftp-data"`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t filter -A INPUT -p tcp --dport 20 -j ACCEPT
fi

temp=`iptables -L INPUT|grep "tcp dpt:ftp"`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t filter -A INPUT -p tcp --dport 21 -j ACCEPT
fi

temp=`iptables -L FORWARD|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D FORWARD -j REJECT --reject-with icmp-host-prohibited
fi

service iptables save>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg

service vsftpd restart>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg

chkconfig vsftpd on

chkconfig --list vsftpd>>/etc/Network_Builder_V0.1/logs/NAT/natk.msg


