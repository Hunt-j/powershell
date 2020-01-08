Import-Module GroupPolicy
$Ohyou = Read-host "Which OU?"

$OU = "OU=$Ohyou,OU=Faculty and Staff,DC=plymouth,dc=edu"
Get-ADOrganizationalUnit "OU=Faculty and Staff,DC=plymouth,dc=edu"

$linkedGPOs = Get-ADOrganizationalUnit "OU=Faculty and Staff,DC=plymouth,dc=edu" | Select-Object -ExpandProperty LinkedGroupPolicyObjects
$linkedGPOs

$linkedGPOUIDs = $linkedGPOs | ForEach-Object{$_.Substring(4,36)}
$linkedGPOUIDs

$linkedGPOUIDs | ForEach-Object {Get-GPO -Guid $_ | Select-Object Displayname}