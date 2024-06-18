# Define the DNS servers
$dnsServers = "172.16.16.10", "172.16.16.254"

# Get all network adapters that are not disabled and have an IP address
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }

foreach ($adapter in $adapters) {
    # Set the DNS servers for each adapter
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses $dnsServers
}
