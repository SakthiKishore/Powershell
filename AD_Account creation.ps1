#Importing Active Directory

Import-Module ActiveDirectory

$exit = ""

while($exit -ne "n")
{

#Get User name and pwd

$firstname = Read-Host -Prompt "Enter your first name"
$secondname = Read-Host -Prompt "Enter your second name"
$password = "Welcome@123"


#Output creds for confirmation

echo "Hi $firstname $secondname, your default password is $password"


#Specify the path

$OUpath = "OU=Powershell users,DC=test,DC=com"

#Convert password to secure string

$securePwd = ConvertTo-SecureString $password -AsPlainText -Force

#Create AD account

New-ADuser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -UserPrincipalName "$firstname.$lastname" -Path $OUpath -AccountPassword $securePwd -ChangePasswordAtLogon $true

Write-Host "AD account successfully created..... Make sure to change the password upon first login"

#Exit condition

$exit = Read-Host -Prompt "Do you want to create another account ? (y/n)"
}

Write-Output "Thank you....Bye"
