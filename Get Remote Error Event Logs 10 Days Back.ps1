#This Script grabs just the ERROR entries in the event log for the past X amount of days
#First enter the computer who's logs you want
$computer= Read-host "Computer Name" 

#Sets the end date as the time of running the script
$end = get-date

#Enter in how many days back you want to grab logs from
$days = Read-host "How many days back?"
$Begin = (get-date).Adddays(-$days)

#Reads the dates back to you
echo "Start Date: $begin"
echo "End Date: $end" 

#IF statement that exports the event logs in a csv to my desktop, and deletes a previous event log csv if one is present
IF(test-path -Path "$env:\desktop\eventlog.csv"){
    remove-item "$env:\desktop\eventlog.csv"
    get-eventlog -ComputerName $computer -LogName System -EntryType Error -After $begin -before $end | export-csv -Path "$env:\desktop\Eventlog.csv"

    }Else{
    get-eventlog -ComputerName $computer -LogName System -EntryType Error -After $begin -before $end | export-csv -Path "$env:\desktop\Eventlog.csv"
    }
