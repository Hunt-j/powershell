$drive = (get-location).Drive.Name

new-item -Path "C:\" -Name "Special Office" -itemtype "Directory"
copy-item -Recurse "$drive`:\Special Office\*" -Destination "C:\Special Office" 
set-location "C:\Special Office"
start-process -FilePath "Install.bat"
