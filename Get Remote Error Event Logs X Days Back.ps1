#This Script grabs just the ERROR entries in the event log for the past X amount of days
#First enter the computer who's logs you want
$computer= Read-host "Computer Name" 

Echo ""

#Pick which log types you want
$logtype= Read-host "Which log type? System, Application, Security?"
$Entrytype= Read-host "Which type of entry? Error, Warning, Information?"

Echo ""

#make a name for the log
$logname=Read-host "Name the log please"

Echo ""

#Sets the end date as the time of running the script
$end = get-date


#Enter in how many days back you want to grab logs from
$days = Read-host "How many days back?"
$Begin = (get-date).Adddays(-$days)

Echo ""

#Reads the dates back to you
echo "Start Date: $begin"
echo "End Date: $end" 

#Couple IFs that let let's you overwrite and alreayd existing CSV
IF(test-path -Path "C:\users\user\desktop\$logname.csv"){
    $overwrite= Read-host "That file path already exists, would you like to overwrite (Y or N)?"
        
        IF($overwrite -eq "Y"){
            
            remove-item "C:\users\user\desktop\$logname.csv"
            get-eventlog -ComputerName $computer -LogName $logtype -EntryType $Entrytype -After $begin -before $end | export-csv -Path "C:\users\user\desktop\$logname.csv"
            
                }ElseIF ($overwrite -eq "N"){

                     Echo ""
                     Echo "Alrighty, exiting session"
                     Exit
                        
                         }ELSE{

                            Echo ""
                            Echo " That's not a Y or an N, c'mon man follow the prompts. Exiting now, all because of you."
                            Exit
                            }  
    }Else{
    get-eventlog -ComputerName $computer -LogName $logtype -EntryType $entrytype -After $begin -before $end | export-csv -Path "C:\users\user\desktop\$logname.csv"
    }
