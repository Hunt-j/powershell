$computer= read-host "computer name"
$pc = Get-ADComputer $computer
$dn = $pc.DistinguishedName
$ldPath = "AD:\",$dn -join ""
$ldObj = Get-ChildItem $ldPath | where {$_.objectClass -eq "msFVE-RecoveryInformation"} | Select-object -Last 1
$ldObj = "AD:\",$ldObj.DistinguishedName -join ""
$btPass = Get-Item $ldObj -properties "msFVE-RecoveryPassword" 
Write-Host $btPass.'msFVE-RecoveryPassword'