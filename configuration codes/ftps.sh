a=`service vsftpd stop|grep OK`

if [[ -z $a ]]
then
	echo "FTP Status: Stopped">/etc/Network_Builder_V0.1/logs/FTP/ftpk.status
else
	echo "FTP Status: Running">/etc/Network_Builder_V0.1/logs/FTP/ftpk.status
	service vsftpd start>>/dev/null
fi
