# Molly Shapiro Ethhack port scanner
#!/bin/bash

# Obtain network prefix from user and check that it's valid. 

ipvalid="n"
while [ $ipvalid == "n" ];
do 
    read -p "What is the network prefix you would like to scan? " host
    if [[ $host =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]
    then
        echo "$host is a valid network prefix."
        ipvalid="y"
    else
        echo "Sorry, $host isn't a valid network prefix. Please try again."
        ipvalid="n"
    fi
done

# Obtain DNS server from user and check that it's valid.
dnsvalid="n"
while [ $dnsvalid == "n" ];
do 
    read -p "What is the DNS server you would like to use? " dns
    if [[ $dns =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]
    then
        scanoutput=$(timeout .1 bash -c "echo >/dev/tcp/$dns/53" 2>/dev/null &&
            echo "$dns:53")
        if [[ $scanoutput == "$dns:53" ]]
        then
            echo "Great, that's a valid DNS server!"
            dnsvalid="y"
        else
            echo "Sorry, that server doesn't have port 53 open. Try again!"
            dnsvalid="n"
        fi
    else
        echo "Sorry, that isn't a valid IP address. Try again!"
        dnsvalid="n"
    fi
done

# Given command from assignment to check which ports are up and running
echo "ip:port"
endip=1
while [ $endip -le 255 ];
do
    stringip=$(echo $endip)
    ip="$host.$endip"
    dnsstring=$(nslookup $ip $dns)
    echo $dnsstring | grep -v "server can't find"
    ((endip++))
done

