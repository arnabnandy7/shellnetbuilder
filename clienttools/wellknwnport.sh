#echo -n "Enter the port number : "
prtn=$1

if [[ -z $prtn ]]
then
	echo "The entered port number is empty.">/etc/Tools/wlp.msg
	exit
fi

#echo -n "Enter protocol type (tcp/udp): "
$prtc=$2

if [[ -z $prtc ]]
then
	echo "The entered protocol type is empty.Please provide type tcp/udp.">>/etc/Tools/wlp.msg
	exit
fi

temp=`cat /etc/services |grep "/$prtc "`

if [[ -z $temp ]]
then
	echo "The entered protocol type is invalid.Please provide correct type tcp/udp.">>/etc/Tools/wlp.msg
	exit
fi


if [[ $prtc=="tcp" ]]
then
	a=`cat /etc/services |grep -w $prtn/tcp|cut -f1 -d ' '`
	if [[ -z $a ]]
	then
		echo "Either the protocol service for this port number is not available or protocol type is invalid please enter any of tcp/udp.">>/etc/Tools/wlp.msg
	else
		echo $a>>/etc/Tools/wlp.msg
	fi
	exit
fi

if [[ $prtc=="udp" ]]
then
	a=`cat /etc/services |grep -w $prtn/udp|cut -f1 -d ' '`
	if [[ -z $a ]]
	then
		echo "Either the protocol service for this port number is not available or protocol type is invalid please enter any of tcp/udp.">>/etc/Tools/wlp.msg
	else
		echo $a>>/etc/Tools/wlp.msg
	fi
	exit
else
	echo "The protocol type is invalid.">>/etc/Tools/wlp.msg
	exit
fi
