$computer= read-host "Computer Name"

$s= New-PSSession -ComputerName "$computer" -Credential "PLYMOUTH\adm-hjarvis"

Invoke-command -session $s {Get-WinEvent -filterHashtable @{logname="security";ID=4672} -Maxevents 30 | select @{n="user";E={$_.Properties[1].Value}}}




