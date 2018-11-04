p=`pwd`
java Encrypter dhcp.sh $p
java Encrypter dhcps.sh $p
java Encrypter dnsupdatedhcp.sh $p
java Encrypter dns.sh $p
java Encrypter dnss.sh $p
java Encrypter nameserver.sh $p
java Encrypter nat.sh $p
java Encrypter http.sh $p
java Encrypter https.sh $p
java Encrypter ftp.sh $p
java Encrypter ftps.sh $p
java Encrypter nfs-server.sh $p
java Encrypter nfss.sh $p
java Encrypter stopnfs.sh $p
java Encrypter startnfs.sh $p
java Encrypter stopall.sh $p
rm -f dhcp.sh dns.sh http.sh ftp.sh nfs-server.sh dhcps.sh dnsupdatedhcp.sh dnss.sh ftps.sh https.sh nfss.sh stopnfs.sh stopall.sh nameserver.sh nat.sh startnfs.sh
