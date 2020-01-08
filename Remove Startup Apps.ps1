#====================================================================================================================================================================================================
#
# Disables all app from starting on boot BESIDES Alertus & Cylance
#
#====================================================================================================================================================================================================

#groups the three registry folders with the startup apps
Start-Transcript -path "C:\startupappsremoved.txt"
$locations = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run","HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run","HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32"

echo $locations
echo ""

#Grabs all the apps names from the $locations folders
  
$items = Foreach($location in $locations)
        {Get-item $locations | Select-Object -ExpandProperty Property}

echo $items

#Rewrites the registry value of each $item in each $location

Foreach($item in $items)
        {Set-ItemProperty $location -name $item -Value ([byte[]](0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00))
        }

Echo ""
Echo "All apps disabled from startup"
Echo ""
Echo "Congratulations!"
Stop-Transcript