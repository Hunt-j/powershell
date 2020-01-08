$Drives = Get-PSDrive -PSProvider FileSystem
foreach($drive in $drives) {
    Copy-Item $drive.Root -Include "Special office\*" 
