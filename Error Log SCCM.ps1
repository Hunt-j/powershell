$Begin = (get-date).Adddays(-$days)
$end = get-date

IF(test-path -Path "\\sccm\DeploymentShare\DesktopSupport\Eventlogs\errorlog.csv"){
    remove-item "\\sccm\DeploymentShare\DesktopSupport\Eventlogs\errorlog.csv"
    Get-eventlog -EntryType Error -LogName System -After $begin -before $end | Export-csv -path "\\sccm\DeploymentShare\DesktopSupport\Eventlogs\errorlog.csv"

    }Else{
    Get-eventlog -EntryType Error -LogName System -After $begin -before $end | Export-csv -path "\\sccm\DeploymentShare\DesktopSupport\Eventlogs\errorlog.csv"
    }