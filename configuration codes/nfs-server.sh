#################################################################
#								#
# 	    NFS server configuration Server Side		#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
else
	echo "Administrative privilage required, unless the application will not work.">/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
	echo "So NFS server configuration is not possible, please login with root privilage">>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
	exit
fi

#yum install nfs

echo "nfs package are installed in system.">>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg

a=`grep "MOUNTD_NFS_V3=\"no\"" /etc/sysconfig/nfs`
if [[ -z $a ]]
then
	echo "MOUNTD_NFS_V3=\"no\"" >> /etc/sysconfig/nfs
fi

a=`grep "MOUNTD_NFS_V2=\"no\"" /etc/sysconfig/nfs`
if [[ -z $a ]]
then
	echo "MOUNTD_NFS_V2=\"no\"" >> /etc/sysconfig/nfs
fi

ip=$1
nt=$2
acsp=$3
pd=$4

if [[ ! -e $pd ]]
then
	mkdir $pd
	echo "The directory is created."
else
	echo "The directory is already exist."
fi

chmod 777 $pd


a=`grep "$pd	$ip/$nt($acsp,sync)" /etc/exports`
if [[ -z $a ]]
then
	echo "$pd	$ip/$nt($acsp,sync)" >> /etc/exports
fi

temp=`iptables -L INPUT|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D INPUT -j REJECT --reject-with icmp-host-prohibited
fi

temp=`iptables -L INPUT|grep "tcp dpt:nfs"`
if [[ -z $temp ]] 			# If the string returns zero then it will be true
then
	iptables -t filter -A INPUT -p tcp --dport 2049 -j ACCEPT
fi

temp=`iptables -L FORWARD|grep "reject-with icmp-host-prohibited"`
if [[ -n $temp ]]			# If the string returns non zero then it will be true
then
	iptables -t filter -D FORWARD -j REJECT --reject-with icmp-host-prohibited
fi

service iptables save>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg

service nfs restart>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
service nfslock restart>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
service rpcbind restart>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg

chkconfig nfs on
chkconfig nfslock on
chkconfig rpcbind on

chkconfig --list nfs>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
chkconfig --list nfslock>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
chkconfig --list rpcbind>>/etc/Network_Builder_V0.1/logs/NFS/nfsk.msg
