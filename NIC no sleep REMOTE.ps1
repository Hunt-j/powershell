$Computer = Read-host "Computer Name"



$S = new-pssession -ComputerName "$computer" -Credential "Plymouth\adm-hjarvis"



Invoke-command $S{
$PhysicalAdapters = Get-WmiObject -Class Win32_NetworkAdapter|Where-Object{$_.PNPDeviceID -notlike "ROOT\*" `
	-and $_.Manufacturer -ne "Microsoft" -and $_.name -ne "juniper networks virtual adapter" -and $_.name -inotlike "*Wireless*" -and $_.name -inotlike "*Bluetooth*" } 
	
Foreach($PhysicalAdapter in $PhysicalAdapters)
	{$PhysicalAdapterName = $PhysicalAdapter.Name
		$DeviceID = $PhysicalAdapter.DeviceID
		If([Int32]$DeviceID -lt 10){
		$AdapterDeviceNumber = "000"+$DeviceID
		
		}Else{

		$AdapterDeviceNumber = "00"+$DeviceID
		}

$keypath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\$AdapterDevicenumber\"

IF(test-path -path $keypath){
    $PNPcap = (Get-ItemProperty -path $keypath).pnpcapabilities
    IF($PNPcap -eq 24){
        Write-host "NIC sleep is already disabled"
        }
        IF($PNPcap -ne 24){
        Set-ItemProperty -Path $keypath -name "PnPCapabilities" -Value 24 
        Write-host "NIC sleep has been disabled"
        }}}
Restart-computer -Force


}
