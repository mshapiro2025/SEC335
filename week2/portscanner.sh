# Molly Shapiro Ethhack port scanner
#!/bin/bash

# Obtain hostfile name from user and check that it exists

hostexist="y"
while [ $hostexist == "y" ];
do
    read -p "What is the file containing the list of hosts? " hostfile
    exists="$(ls | grep $hostfile)"
    if [[ $exists == $hostfile ]]
    then
        echo "Great, that's a valid host file!"
        hostexist="n"
    else
        echo "Sorry, that file doesn't exist in this directory. Let's try again!"
        hostexist="y"
    fi
done

# Obtain portfile name from user and check that it exists.

portexist="y"
while [ $portexist == "y" ];
do
    read -p "What is the file containing the list of ports? " portfile
    exists="$(ls | grep $portfile)"
    if [[ $exists = $portfile ]]
    then
        echo "Great, that's a valid port file!"
        portexist="n"
    else
        echo "Sorry, that file doesn't exist in this directory. Let's try again!"
        hostexist="y"
    fi
done

# Checks that each line in the host file is a valid host. 
for host in $(cat $hostfile);
do
    if [[ $host =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]
    then
        echo "$host is a valid IP."
    else
        echo "Sorry, $host isn't a valid host. Please try again."
        exit
    fi
done

# Checks that each line in the port file is a valid port. 
for port in $(cat $portfile);
do 
    if [[ $port =~ [0-9]{1,5} ]]
    then
        echo "$port is a valid port."
    else
        echo "Sorry, $port isn't a valid port. Please try again."
        exit
    fi
done

# Given command from assignment to check which ports are up and running
echo "host:port"
for host in $(cat $hostfile);
do
    for port in $(cat $portfile);
    do
        timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
            echo "$host:$port"
    done
done
