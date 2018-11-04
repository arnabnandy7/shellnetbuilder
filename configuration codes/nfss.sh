a=`service nfs stop|grep OK`
b=`service nfslock stop|grep OK`
c=`service rpcbind stop|grep OK`

if [[ -z $a && -z $b && -z $c ]]
then
	echo "NFS Status: Stopped">/etc/Network_Builder_V0.1/logs/NFS/nfsk.status
else
	echo "NFS Status: Running">/etc/Network_Builder_V0.1/logs/NFS/nfsk.status
	service nfs start>>/dev/null
	service nfslock start>>/dev/null
	service rpcbind start>>/dev/null
fi
