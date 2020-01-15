<#
    .SYNOPSIS
        Disables Wired NIC from sleeping

    .DESCRIPTION
        This script identifies the ethernet NIC and prevent the computer from putting it to sleep
        
    .FUNCTIONALITY
        

    .NOTES
            AUTHOR: Hunter Jarvis
            EMAIL: hjarvis@plymouth.edu

#>

# Define Log name and directory
$logpath = "C:\windows\temp\logs"
$ScriptName = $MyInvocation.MyCommand.Name
$ScriptDirectory = Split-Path $MyInvocation.MyCommand.Path -Parent
$LogName = "$ScriptName-$((Get-Date).ToString('yyyy-MM-dd-HHmmss')).log"
if (!(Test-Path $Logpath)) {New-Item -ItemType Directory -Path $Logpath}

#Start logging
Start-Transcript -Path (Join-Path $Logpath $LogName)
Write-Host ""
Write-Host "Starting $ScriptName from $ScriptDirectory" -ForegroundColor Yellow

#Identifies all wired NICs that aren't ROOT, Microsoft, VPN, Wireless, or Bluetooth, and takes the "number(s)" they're assigned
$PhysicalAdapters = Get-WmiObject -Class Win32_NetworkAdapter|Where-Object{$_.PNPDeviceID -notlike "ROOT\*" `
-and $_.Manufacturer -ne "Microsoft" -and $_.name -ne "juniper networks virtual adapter" -and $_.name -inotlike "*Wireless*" -and $_.name -inotlike "*Bluetooth*"} 

#Takes the number(s) and appends the appropriate zeros so that their registry locations are accurate
Foreach($PhysicalAdapter in $PhysicalAdapters){
    $PhysicalAdapterName = $PhysicalAdapter.Name
	$DeviceID = $PhysicalAdapter.DeviceID
	If([Int32]$DeviceID -lt 10){
		$AdapterDeviceNumber = "000"+$DeviceID
	}Else{
        $AdapterDeviceNumber = "00"+$DeviceID
	}

#This is the registry path where the NIC sleep setting lives
    $keypath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\$AdapterDevicenumber\"

#Sets the registry value(s) to 24, which disables the NIC(s) from sleeping and lets you know if the setting has already been disabled
    IF(test-path -path $keypath){
        $PNPcap = (Get-ItemProperty -path $keypath).pnpcapabilities
        IF($PNPcap -eq 24){
            Write-host "NIC sleep is already disabled"
        }ELSE{       
            Set-ItemProperty -Path $keypath -name "PnPCapabilities" -Value 24
            Write-host "NIC sleep has been disabled"

        }
    }
}

#Disables and re-enables all the network adapters so that the setting is applied (rebooting computer also works)
Disable-netadapter -name "*" -confirm:$False
Enable-NetAdapter -name "*"  -confirm:$False

Stop-transcript

