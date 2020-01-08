#Pull all the user profiles on the endpoint, defined by those who have an NTUSER.DAT file. Pull only their name and ignore those who's profiles you can't access. 
Write-Host "Checking User Folder sizes."
$profiles = Get-ChildItem C:\Users |  Select -ExpandProperty Name


  #Run through each profile and sum the total size of all files, then divide by MB for something a bit more human readable.
  foreach($profile in $profiles){
     
    #This is adapted from my Backup script and seems to do the trick here. 
    $BSize = "{0:N2} MB" -f ((Get-ChildItem -Path C:\Users\$profile\*  -Recurse -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }  | Measure-Object -Property Length -Sum).Sum / 1MB)
      
    #Super simple formatting to help readability. A quick if/then cuts out the profiles that we don't have access to on this computer.
    If($BSize -lt 1){
        Write-Host "$profile empty or inaccessible"
    }Else{
        Write-Host "$profile is $BSize"
    }   
    Write-Host ""

    }