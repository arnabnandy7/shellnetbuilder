#################################################################
#								#
# 	    NFS client configuration Server Side		#	
#								#
#################################################################

chk=`whoami`

if [[ $chk == "root" ]]
then
	echo "User is root.">/etc/Tools/cnfsk.msg
else
	echo "Administrative privilage required, unless the application will not work.">/etc/Tools/cnfsk.msg
	echo "So NFS client configuration is not possible, please login with root privilage">>/etc/Tools/cnfsk.msg
	exit
fi

yum install nfs

echo "nfs package are installed in system.">>/etc/Tools/cnfsk.msg

#echo -n "Enter path of directory to be get shared documents (/home/System/Desktop/data): "
$pd=$3

if [[ ! -e $pd ]]
then
	mkdir $pd
	echo "The directory is created.">>/etc/Tools/cnfsk.msg
else
	echo "The directory is already exist.">>/etc/Tools/cnfsk.msg
fi

chmod 777 $pd

#echo -n "Enter IP address of source or server NFS : "
$ip=$1
#echo -n "Enter path of directory of server NFS (/Share): "
$srvp=$2

mount -t nfs $ip:$srvp $pd

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

service iptables save>>/etc/Tools/cnfsk.msg

service rpcbind restart>>/etc/Tools/cnfsk.msg

chkconfig rpcbind on

chkconfig --list rpcbind>>/etc/Tools/cnfsk.msg
