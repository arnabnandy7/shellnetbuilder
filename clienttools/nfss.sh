a=`service rpcbind stop|grep OK`

if [[ -z $a ]]
then
	echo "NFS Status: Stopped">/etc/Tools/cnfsk.status
else
	echo "NFS Status: Running">/etc/Tools/cnfsk.status
	service rpcbind start>>/dev/null
fi
