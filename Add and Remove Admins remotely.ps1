<#
    .SYNOPSIS
        Make a domain user an admin on a remote computer and/or remove an admin user

    .DESCRIPTION
        Select a computer, then enter a domain user's username to make them an administrator on that computer. After adding you can then un-make and admin on the same computer.
        
    .FUNCTIONALITY
        
    .NOTES
            AUTHOR: Hunter Jarvis
            EMAIL: hjarvis@plymouth.edu
#>


#Has you enter in the pc name you want and keeps it.
$Computername= Read-host "Computer Name"

#This is the puts that computer name against AD"
$Computercheck= Get-ADComputer -Filter 'Name -like $Computername' 
Echo ""

#This IF just let's you know (without red) if that is actually a computer in AD or not.
IF($Computercheck -match $Computername){

#Creates a remote session to call back to.
    $s= New-PSSession -ComputerName $computername -Credential "PLYMOUTH\adm-hjarvis"

#Has you enter in a username that will be the new admin on the remote PC.
    Echo "New Admin"
    Invoke-Command -Session $s {$newadmin= Read-Host "Username"}
    Echo ""

#grabs the current admins and checks if the one you're adding is already an admin. Adds that user to admins if not already there.
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
            Add-LocalGroupMember -Group Administrators -Member "plymouth\$newadmin"
            Echo ""
            (Get-LocalGroupMember -Group Administrators).name
            Echo ""
            Echo "Added User"
            Echo "Well Done!"
        }
    }

#Shows the new list of admins then asks if you want to remove a user as an admin.
    Invoke-Command -Session $s {$admindouble= Get-LocalGroupMember -Group Administrators | Select-Object -Property name} 
    Invoke-Command -Session $s {Echo "$admindouble"}       
    Invoke-Command -Session $s {$remove?= Read-host "Remove Admins (Y or N)?"}
    Invoke-Command -Session $s {IF($remove? -eq "y") {
   
        Echo "" 
        Echo "Admin to Remove"
        $removeadmin= Read-Host "Username"
        Echo ""
        IF($admindouble -match "$removeadmin"){
            Remove-LocalGroupMember -Group Administrators -Member "plymouth\$removeadmin"
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
            Exit}
    }
    }ELSE{
        Echo "That computer name doesn't exist, try again."
}
 