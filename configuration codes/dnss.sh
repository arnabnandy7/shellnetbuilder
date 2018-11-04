a=`service named stop|grep OK`

if [[ -z $a ]]
then
	echo "DNS Status: Stopped">/etc/Network_Builder_V0.1/logs/DNS/dnsk.status
else
	echo "DNS Status: Running">/etc/Network_Builder_V0.1/logs/DNS/dnsk.status
	service named start>>/dev/null
fi
