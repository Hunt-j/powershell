
$computername= Read-host "Computer Name"
Echo ""

$s= New-PSSession -ComputerName $computername -Credential "DOMAIN\USER"
Echo "New Admin"
Invoke-Command -Session $s {$newadmin= Read-Host "Username"}
Echo ""
    Invoke-Command -Session $s {$admindouble= Get-LocalGroupMember -Group Administrators | Select-Object -Property name}
    Invoke-Command -Session $s {IF($admindouble -match "$newadmin"){
           
          Echo ""
          Echo "User is already and Admin on this computer" 
          Echo ""
          Echo "Current Admins"
          (Get-LocalGroupMember -Group Administrators).name 
          Echo ""
        }ELSE{ 
            Echo ""
            Add-LocalGroupMember -Group Administrators -Member "DOMAIN\$newadmin"
            echo ""
            (Get-LocalGroupMember -Group Administrators).name
        }}
        
$remove?= Read-host "Remove Admins (Y or N)?"
IF($remove? -eq "y") {
    Echo ""
    Echo "Admin to Remove"
    Invoke-Command -Session $s {$removeadmin= Read-Host "Username:"}
    Echo ""
    Invoke-Command -session $s {Remove-LocalGroupMember -Group Administrators -Member "DOMAIN\$removeadmin"}
    Invoke-Command -Session $s {(Get-LocalGroupMember -Group Administrators).name}
 
    } Else {
    
    Exit}

 
