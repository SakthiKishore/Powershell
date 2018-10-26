#Login to the ESXi host

echo "Connecting to ESXi server ...."

do
    {
    Connect-VIServer -Server 10.192.34.201 -ErrorVariable wrong_cred -ErrorAction SilentlyContinue
    if ($wrong_cred)
        {
        Write-Warning -Message "Oops! Invalid Credentials...Try Again or press CTRL+C to exit" 
        }
    }until($wrong_cred = 0)

#Display the list of VMs present in the ESXi

Write-Host "#####################################################################"
Write-Host " Current list of VMs in the ESXi server..."
Write-Host "#####################################################################"
Get-VM
Write-Host ""

$action = Read-Host -Prompt "Do you want to spin up NetMRI..? (yes/no)"

switch ($action)
{
    'yes' {}
    'no' { Write-Host "Ok Bye....." ; break } 
     
}


$vmName = Read-Host -Prompt "Specify the VM name"
