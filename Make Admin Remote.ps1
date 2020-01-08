
$computername= Read-host "Computer Name"

    


$s= New-PSSession -ComputerName $computername -Credential plymouth\adm-hjarvis


Invoke-Command -Session $s {$newadmin= Read-Host  "Username"}
Invoke-Command -session $s {Add-LocalGroupMember -Group Administrators -Member "plymouth\$newadmin"}
Invoke-Command -Session $s {Get-LocalGroupMember -Group Administrators | Select-Object -Property Pscomputername,name}


