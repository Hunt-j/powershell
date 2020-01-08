#kill processes that need to be closed for caches to clear
get-process -name "*chrome*" | stop-process
get-process -name "*firefox*" | stop-process
get-process -name "*adobe*" | Stop-process 
get-process -name "*acrobat*" | Stop-process 
get-process -name "Acrodist" | Stop-process
get-service -name "*adobe*" | Stop-service
get-service -name "*acrobat*" | Stop-service
get-process -name "*onedrive*" | Stop-process
get-process -name "FileCoAuth" | stop-process
get-process -name "iexplore" | stop-process
get-process -name "*edge*" | stop-process
#Sets $user to be whomever the current user is
$user = $env:username
#Clears recycle bin and every temp file/cache folder that's necessary
Clear-RecycleBin -Force
remove-item -path "C:\users\$user\AppData\local\Temp\*" -Recurse -Force 
remove-item -path "C:\Windows\temp\*" -recurse -force
remove-item -path "C:\Users\$user\AppData\Local\Mozilla\Firefox\Profiles\*.default\Offlinecache\*" -recurse -force
remove-item -path "C:\Users\$user\AppData\Local\Mozilla\Firefox\Profiles\*.default\startupecache\*" -recurse -force
remove-item -path "C:\Users\$user\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -recurse -force
remove-item -Path "C:\Users\$user\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*" -recurse -force
remove-item -Path "C:\Users\$user\AppData\Local\Microsoft\Windows\INetCache\*" -recurse -force
remove-item -Path "C:\Users\$user\AppData\Local\Packages\Microsoft.MicrosoftEdge_*\AppData\User\Default\Indexed DB\*" -recurse -force
remove-item -Path "C:\Users\$user\AppData\Local\Packages\Microsoft.MicrosoftEdge_*\LocalCache\*" -recurse -force
remove-item -Path "C:\Users\$user\AppData\Local\Packages\Microsoft.MicrosoftEdge_*\TempState\*" -recurse -force