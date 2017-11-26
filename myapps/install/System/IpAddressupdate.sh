# !/bin/bash

#http://api.ident.me/

curl -s -o /tmp/ipv4.txt https://v4.ident.me/
#if IPV6 is enabled
curl -s -o /tmp/ipv6.txt https://v6.ident.me/

echo "IPV4 Address: "$(cat /tmp/ipv4.txt)
ipv4=$(cat /tmp/ipv4.txt)

if [ ! -f /tmp/ipv6.txt ]; then
    echo "IPV6 Address: NONE"
  else
    echo "IPV6 Address: "$(cat /tmp/ipv6.txt)
    ipv6=$(cat /tmp/ipv6.txt)
    echo 
fi

echo "Checking if any Updates are needed"
if [ ! -f /tmp/ipv6.txt ]; then
    wget -q -O /tmp/results.txt "https://api.dynu.com/nic/update?hostname=xxxdomainxxx&myip=$ipv4&username=xxxusernamexxx&password=xxxpasswordxxx"
  else  
    wget -q -O /tmp/results.txt "https://api.dynu.com/nic/update?hostname=xxxdomainxxx&myip=$ipv4&myipv6=$ipv6&username=xxxusernamexxx&password=xxxpasswordxxx"
fi

cat /tmp/results.txt

rm /tmp/results.txt /tmp/ipv4.txt 
if [ ! -f /tmp/ipv6.txt ]; then
    echo ""
  else
    rm /tmp/ipv6.txt
fi

# https://www.dynu.com/en-US/DynamicDNS/IP-Update-Protocol
#unknown  This response code is returned if an invalid 'request' is made to the API server. This 'response code' could be generated as a result of badly formatted parameters as well so parameters must be checked for validity by the client before they are passed along with the 'request'. 
#good  This response code means that the action has been processed successfully. Further details of the action may be included along with this 'response code'. 
#badauth  This response code is returned in case of a failed authentication for the 'request'. Please note that sending across an invalid parameter such as an unknown domain name can also result in this 'response code'. The client must advise the user to check all parameters including authentication parameters to resolve this problem. 
#servererror  This response code is returned in cases where an error was encountered on the server side. The client may send across the request again to have the 'request' processed successfully. 
#nochg  This response code is returned in cases where IP address was found to be unchanged on the server side. 
#notfqdn  This response code is returned in cases where the hostname is not a valid fully qualified hostname. 
#numhost  This response code is returned in cases where too many hostnames(more than 20) are specified for the update process. 
#abuse  This response code is returned in cases where update process has failed due to abusive behaviour. 
#nohost  This response code is returned in cases where hostname/username is not found in the system. 
#911  This response code is returned in cases where the update is temporarily halted due to scheduled maintenance. Client must respond by suspending update process for 10 minutes upon receiving this response code. 
#dnserr  This response code is returned in cases where there was an error on the server side. The client must respond by retrying the update process. 
 #!donator  This response code is returned to indicate that this functionality is only available to members. 
 
