$computername= Read-host "Computer Name"

(([adsisearcher]"(&(name=$computername)(objectClass=computer))").FindAll().path -split ",*..=")[1,3]
