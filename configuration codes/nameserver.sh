zn=$1
dn=$2
dnip=$3


se=`grep "serial" /var/named/$zn |cut -f1 -d ';'`
tmpse=$se
((se+=1))

echo >/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg

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

service named restart>>/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg
