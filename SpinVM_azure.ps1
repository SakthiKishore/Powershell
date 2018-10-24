#Login to the Azure portal



# Variables for common values



# Create a resource group
$resourceGroup = Read-Host -Prompt "Specify the resource group name"
New-AzureRmResourceGroup -Name $resourceGroup -Location $location


$location = "West US"
$vmName = Read-Host -Prompt "Specify the VM name"

# Create user object
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."


# Create a virtual network

echo "Creating a virtual network with address space 192.168.0.0/16....... "
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name MyVnet -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig


# Create a subnet configuration

echo "Creating subnet 192.168.1.0/24 ......"
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name mySubnet -AddressPrefix 192.168.1.0/24



# Create a public IP address and specify a DNS name

echo "Fetching a public IP address and DNS name..... "
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Location $location -Name "mypublicdns$(Get-Random)" -AllocationMethod Static -IdleTimeoutInMinutes 4



# Create an inbound network security group rule for port 3389

$nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRDP  -Protocol Tcp `
  -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * `
  -DestinationPortRange 3389 -Access Allow

# Create a network security group

$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroup -Location $location `
  -Name myNetworkSecurityGroup -SecurityRules $nsgRuleRDP

# Create a virtual network card and associate with public IP address and NSG

$nic = New-AzureRmNetworkInterface -Name myNic -ResourceGroupName $resourceGroup -Location $location `
  -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# Create a virtual machine configuration

echo "Finalizing configuration......"
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize Standard_D1 | `
Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred | `
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest | `
Add-AzureRmVMNetworkInterface -Id $nic.Id

# Create a virtual machine

echo "Creating the Virtual machine.........."
New-AzureRmVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig
echo "Successfully created Virtual Machine with inbound access via RDP...."
Get-AzureRmVM -Name $vmName
