# Molly Shapiro
# Powershell and DNS Assignment - SEC335

$dnsserver = read-host -Prompt "Please enter the IP address of the DNS server you would like to use."
$netprefix = read-host -Prompt "Please enter the network prefix of the network you would like to use."

for ($ipend = 1; $ipend -le 255; $ipend++) {
    $ip = $netprefix + "." + $ipend
    $dnsname = Resolve-DnsName -DnsOnly $ip -Server $dnsserver -ErrorAction Ignore | Select-Object NameHost
    if ($dnsname) {
    echo $ip `t $dnsname
    }
}
