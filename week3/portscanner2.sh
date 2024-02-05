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

# Given command from assignment to check which ports are up and running
echo "ip:port"
endip=1
while [ $endip -le 255 ];
do
    stringip=$(echo $endip)
    ip="$host.$endip"
    timeout .1 bash -c "echo >/dev/tcp/$ip/53" 2>/dev/null &&
        echo "$ip:53"
    ((endip++))
done
