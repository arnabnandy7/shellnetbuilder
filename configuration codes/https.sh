a=`service httpd stop|grep OK`

if [[ -z $a ]]
then
	echo "HTTP Status: Stopped">/etc/Network_Builder_V0.1/logs/HTTP/httpk.status
else
	echo "HTTP Status: Running">/etc/Network_Builder_V0.1/logs/HTTP/httpk.status
	service httpd start>>/dev/null
fi
