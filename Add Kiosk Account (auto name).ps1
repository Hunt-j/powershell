do{

    #collect the domained kiosk account credentials
    ""
    $kioskusername = 'kiosk'
    $kioskpassword = '1m4kiosk'
    $kioskpassword2 = '1m4kiosk'
    $RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

    #make sure the password has been typed correctly
    if($kioskpassword -eq $kioskpassword2)
    {
        try
        {  
            #update the registry
            Set-ItemProperty $RegistryPath "AutoAdminLogon" -Value "1" -type String 
            Set-ItemProperty $RegistryPath "DefaultUsername" -Value "$kioskusername" -type String 
            Set-ItemProperty $RegistryPath "DefaultPassword" -Value "$kioskpassword" -type String
            Set-ItemProperty $RegistryPath "DefaultDomainName" -Value "PLYMOUTH" -type String
            break
        }
        catch
        {
            write-host 'Registry Update Error'
        }

    }
    else
    {
        ""
        Write-Host 'Passwords do not match - try again...'
    }
}
while($true)
""
write-Host 'Kiosk Account Setup Complete'
