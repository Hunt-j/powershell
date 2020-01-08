
#This installs ODBC according to the steps outlined in "Oracle-ODBC setup.docx"

#sets $user as whomever the current user is
$user = $env:username

#Copies the oracle folder to desktop and replaces if already present.
Echo "Testing path for Oracle 12 installation folder."
If(Test-Path -Path "C:\users\$user\desktop\Oracle 12 client"){
    Remove-Item "C:\users\$user\desktop\Oracle 12 client" -Recurse
    echo "Old Oracle installation folder located, removing folder for fresh copy."
    Copy-Item '\\charon\pub\Oracle 12 client'-destination C:\users\$user\desktop\ -Recurse | out-null
    echo "Copying new installation folder to desktop."
    }Else{
        Copy-Item '\\charon\pub\Oracle 12 client'-destination C:\users\$user\desktop\ -Recurse | out-null
        echo "Copying new installation folder to desktop."
     }

#Copies Oracle folder from "Oracle 12 Client" to "C:\program files (x86)\", and replaces if already present.
Echo "Moving Oracle folder to Program Files."
If(Test-path -Path "C:\Program Files (x86)\Oracle"){
    Echo "Located old Oracle folder in Program Files, removing for a fresh copy."
    Remove-item -Force "C:\Program Files (x86)\Oracle" -Recurse
    Echo "Copying new Oracle folder into Program Files."
    copy-item "C:\Users\$user\Desktop\Oracle 12 Client\Oracle" -Destination "C:\Program Files (x86)\" -Recurse | out-null
    }Else{
        "Copying Oracle folder into Program Files."
        copy-item "C:\Users\$user\Desktop\Oracle 12 Client\Oracle" -Destination "C:\Program Files (x86)\" -Recurse | out-null

    }
 
#Runs that .bat to isntall the odbc driver. This does (for whatever reason) need to be run from cmd.exe, hense the .bat.   
Echo "Installing ODBC driver."
Start-Process -filepath "C:\users\$user\Desktop\oracle 12 client\odbc install\odbc.bat" -verb runas

#Runs te vcredist installer
Echo "Installing vcredist."
Start-process -FilePath "C:\users\$user\Desktop\Oracle 12 client\vcredist_x86.exe" -ArgumentList "/q" -wait

#Extracts the contents of "BDE_with_SQL_Links.zip" to a new folder "BDE" in the "Oracle 12 Client" on the desktop. Replaces if already present.
Echo "Testing path for BDE."
If(Test-path -path "C:\users\$user\Desktop\Oracle 12 client\BDE"){
    Echo "Old BDE folder found, removing for a fresh copy."
    Remove-Item "C:\Users\$user\Desktop\Oracle 12 client\BDE" -Recurse
    Echo "Unpacking BDE."
    Expand-Archive -Path "C:\users\$user\Desktop\Oracle 12 client\BDE_with_SQL_Links.zip" -DestinationPath "C:\Users\$user\Desktop\Oracle 12 client\BDE\" -Force | out-null
       }Else{
            Echo "Unpacking BDE."
            Expand-Archive -Path "C:\users\$user\Desktop\Oracle 12 client\BDE_with_SQL_Links.zip" -DestinationPath "C:\Users\$user\Desktop\Oracle 12 client\BDE\" -force | out-null
       }

#Runs the setup.exe from the new BDE folder created in the last step.
Echo "Installing BDE. User may have to click through installation, accept all defaults."
Start-Process "C:\Users\$user\Desktop\Oracle 12 client\BDE\setup.exe" -ArgumentList '/S' -Wait

#Creates the TNS ADMIN environment variable.
Echo "Setting TNS ADMIN variable."
[Environment]::SetEnvironmentVariable("TNS_ADMIN","C:\Program Files (x86)\Oracle\tns","machine") | out-null

#Gives echo confirmation feedback and starts the ODBC application to confirm succesfull installation.
Echo "____"
Echo ""
Echo "Installation complete. Check ODBC application for Oracle in Oracle driver."
Echo ""
Start-Process "C:\WINDOWS\syswow64\odbcad32.exe"
pause



