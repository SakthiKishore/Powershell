#Login to the ESXi host

echo "Connecting to ESXi server ...."
Connect-VIServer -Server 10.192.34.201 -ErrorVariable wrong_cred -ErrorAction SilentlyContinue
if ($wrong_cred)
    {
    Write-Warning -Message "Oops! Invalid Credentials...Try Again"
    }
