<#
This script is designed to connect to a remote computer and allow you add a user as an admin.
It then asks if you'd like to remove an administrator from the computer.


#>

#Has you enter in the pc name you want and keeps it.
$Computername= Read-host "Computer Name"

#This is the puts that computer name against AD"
$Computercheck= Get-ADComputer -Filter 'Name -like $Computername' 
Echo ""

#This IF just let's you know (without red) if that is actually a computer in AD or not.
IF($Computercheck -match $Computername){

#Creates a remote session to call back to.
$s= New-PSSession -ComputerName $computername -Credential "DOMAIN\USER"

#Has you enter in a username that will be the new admin on the remote PC.
Echo "New Admin"
Invoke-Command -Session $s {$newadmin= Read-Host "Username"}
Echo ""

    #This is a big IF-ELSE that checks if the usename you entered is already and admin,
    #if $newadmin is already an admin it tells you, does nothing in this step, and moves on.
    #if $newadmin isn't an admin, it is then added to the administrators local group.
    Invoke-Command -Session $s {$admindouble= Get-LocalGroupMember -Group Administrators | Select-Object -Property name}
    Invoke-Command -Session $s {IF($admindouble -match "$newadmin"){

          #Lot's of echo spacing to make it easier to look at. 
          Echo ""
          Echo "User is already and Admin on this computer" 
          Echo ""
          Echo "Current Admins"
          (Get-LocalGroupMember -Group Administrators).name 
          Echo ""
        }ELSE{ 
            Echo ""
            Add-LocalGroupMember -Group Administrators -Member "DOMAIN\$newadmin"
            Echo ""
            (Get-LocalGroupMember -Group Administrators).name
            Echo ""
            Echo "Added User"
            Echo "Well Done!"
        }}

#
Invoke-Command -Session $s {$admindouble= Get-LocalGroupMember -Group Administrators | Select-Object -Property name} 
Invoke-Command -Session $s {Echo "$admindouble"}       
Invoke-Command -Session $s {$remove?= Read-host "Remove Admins (Y or N)?"}
Invoke-Command -Session $s {IF($remove? -eq "y") {
   
    Echo "" 
    Echo "Admin to Remove"
    $removeadmin= Read-Host "Username"
    Echo ""
        IF($admindouble -match "$removeadmin"){
               Remove-LocalGroupMember -Group Administrators -Member "DOMAIN\$removeadmin"
               (Get-LocalGroupMember -Group Administrators).name
               Echo ""
               Echo "Admin Removed"
               Echo "Conragtulations!"
            }ELSE{
               Echo ""
               Echo "$removeadmin wasn't an admin to begin with. Exiting"
               Echo ""
            }
        }ElseIF ($remove? -eq "n"){
            Echo ""
            Echo "Exiting Session"
        }ELSE{
            Echo ""
            Echo " That's not a Y or an N, c'mon man follow the prompts. Exiting now, all because of you."
    Exit}}
}ELSE{
    Echo "That computer name doesn't exist, try again."
}
 
