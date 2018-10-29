Connect-VIServer -Server 10.192.34.201

Get-VM

$ovfPath = "https://10.192.34.201/folder?dcPath=ha-datacenter&dsName=datastore1"

$ovfConfig = Get-OvfConfiguration -Ovf $ovfPath




function createvm
{



https://10.192.34.201/folder?dcPath=ha-datacenter&dsName=datastore1
