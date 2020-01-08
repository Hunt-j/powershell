$cutoff = (Get-Date).AddDays(-180)

$filter = "LastLogonDate -gt '$cutoff' -and (OperatingSystem -Like 'Windows 7 Enterprise')"

Get-ADComputer -Filter $filter -Searchbase "OU=Faculty and Staff,DC=Plymouth,dc=edu" -Properties Name,OperatingSystem,LastLogonDate | 
    Sort Name 

      