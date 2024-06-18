# Define the new subnet mask
$newSubnetMask = "255.255.0.0"

# Get all network adapters
$networkAdapters = Get-NetAdapter -Physical

foreach ($adapter in $networkAdapters) {
    # Get the current IP configuration
    $ipConfig = Get-NetIPAddress -InterfaceIndex $adapter.IfIndex -AddressFamily IPv4
    foreach ($ip in $ipConfig) {
        # Change the subnet mask
        Set-NetIPAddress -InterfaceIndex $adapter.IfIndex -IPAddress $ip.IPAddress -PrefixLength 16
    }
}
