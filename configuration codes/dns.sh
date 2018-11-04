#################################################################
#								#
# 		    DNS server configuration			#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root." > /etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
else
	echo "Administrative privilege required, unless the application will not work." > /etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
	echo "So DNS configuration is not possible, please login with root privilege">>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
	exit
fi

a=`rpm -qa|grep -w bind|wc -l`
if [[ $a -le 2 ]] 
then
	#yum install bind*
	echo "Bind package are not installed in system.">>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
else
	echo "Bind package are installed in system.">>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
fi


rf=1
rt=2
ex=1
mn=1

zn=$1
dn=$2
dnip=$3

cp /etc/named.conf /tmp/named.conf
q=`wc -l /tmp/named.conf|cut -f1 -d ' '`

echo > /etc/named.conf

for (( i=1; i<=$q; i++ ))
do
	fl=0
	a=`head -$i /tmp/named.conf |tail -1`
	head -$i /tmp/named.conf |tail -1 > /tmp/ext
	temp=`grep "{ 127.0.0.1; };" /tmp/ext`
	if [[ -n $temp ]]
	then
		echo "        listen-on port 53 { 127.0.0.1;any; };" >> /etc/named.conf
		fl=1
	fi
	temp=`grep "{ localhost; };" /tmp/ext`
	if [[ -n $temp ]]
	then
		echo "        allow-query     { localhost;any; };" >> /etc/named.conf
		fl=1
	fi
	
	tmp=`grep $zn /etc/named.conf`
	if [[ -z $tmp ]]
	then
		if [[ $a == "include \"/etc/named.rfc1912.zones\";" ]]
		then
			echo "zone \"$zn\" IN {" >> /etc/named.conf
			echo "        type master;" >> /etc/named.conf
			echo "        file \"$zn\";" >> /etc/named.conf
			echo "};" >> /etc/named.conf
			echo >> /etc/named.conf
		fi	
	fi	

	if [[ fl -ne 1 ]]
	then
		 head -$i /tmp/named.conf |tail -1 >> /etc/named.conf
	fi
done

rm -f /tmp/named.conf /tmp/ext

if [[ -e /var/named/$zn ]]
then
	se=`grep "serial" /var/named/$zn |cut -f1 -d ';'`
	tmpse=$se
	((se+=1))
else
	se=`echo $RANDOM`
fi

#echo $tmpse

vrf="$rf D"
vrf=`echo $vrf | sed -e "s/ //g"`
vrt="$rt H"
vrt=`echo $vrt | sed -e "s/ //g"`
vex="$ex W"
vex=`echo $vex | sed -e "s/ //g"`
vmn="$mn H"
vmn=`echo $vmn | sed -e "s/ //g"`

if [[ -e /var/named/$zn ]]
then
	if [[ ! `egrep "serial" /var/named/$zn` ]]
	then
		rm -f /var/named/$zn
	fi
fi

if [[ ! -e /var/named/$zn ]]
then
	echo "\$TTL 1D" > /var/named/$zn
	echo "@ IN SOA $zn. admin.$zn. (" >> /var/named/$zn
	echo "			 $se ; serial" >> /var/named/$zn
	echo "			$vrf ; refresh" >> /var/named/$zn
	echo "			$vrt ; retry" >> /var/named/$zn
	echo "			$vex ; expire" >> /var/named/$zn
	echo "			$vmn); minimum" >> /var/named/$zn

	echo "@ IN NS $dn.$zn." >> /var/named/$zn
	echo "$dn IN A $dnip" >> /var/named/$zn
else
	cp /var/named/$zn /tmp/$zn

	q=`wc -l /tmp/$zn|cut -f1 -d ' '`

	echo > /var/named/$zn

	for (( i=1; i<=$q; i++ ))
	do
		fl=0
		head -$i /tmp/$zn |tail -1 > /tmp/ext
		a=`grep "; serial" /tmp/ext`
		if [[ -n $a ]]
		then
			echo "			 $se ; serial" >> /var/named/$zn
			fl=1
		fi

		if [[ fl -ne 1 ]]
		then
			head -$i /tmp/$zn |tail -1 >> /var/named/$zn
		fi
	done
	a=`grep "@ IN NS $dn.$zn." /var/named/$zn`
	if [[ -z $a ]]
	then
		echo "@ IN NS $dn.$zn." >> /var/named/$zn
		echo "$dn IN A $dnip" >> /var/named/$zn
	fi
fi

cp /etc/named.conf /tmp/nm

a=`cat /etc/named.conf|wc -l`

rm -f /etc/named.conf
touch /etc/named.conf

for (( i=1; i<$a; i++ ))
do
        b=`head -$i /tmp/nm|tail -1`
        if [[ -n $b ]]
        then
                head -$i /tmp/nm|tail -1>>/etc/named.conf
        fi
done

tmp=`grep "include \"/etc/named.root.key\";" /etc/named.conf`
if [[ -z $tmp ]]
then
	echo "include \"/etc/named.root.key\";" >>/etc/named.conf
fi

rm -f /tmp/$zn /tmp/ext /tmp/nm

chgrp named /var/named/$zn		# changing zone files permission to named user

temp=`iptables -L INPUT|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D INPUT -j REJECT --reject-with icmp-host-prohibited
fi

temp=`iptables -L INPUT|grep "tcp dpt:domain"`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
fi

temp=`iptables -L FORWARD|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D FORWARD -j REJECT --reject-with icmp-host-prohibited
fi

service iptables save>>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg

service named restart>>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg

chkconfig named on

chkconfig --list named >>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg

