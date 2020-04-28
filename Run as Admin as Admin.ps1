<#This one is for a specific need. You are not logged into a computer as a domain admin,
   but you need to run powershell as an adminitrator AND a domain admin.
 #>
 
 $Domain = Read-host "Domain?"
 $username = Read-host "Username?"
 
 start-process powershell.exe -Credential $domain\$username -NoNewWindow -ArgumentList "Start-Process powershell_ise.exe -verb runas"
