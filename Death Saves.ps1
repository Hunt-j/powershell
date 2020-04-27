#Death Save passive counter

Function D20 {get-random -minimum 1 -Maximum 21}
$S1=d20
$S2=d20
$S3=d20
$S4=d20
$S5=d20
$S6=d20

$Failures = 0;
$Death = 3;
$Saves = 0;
$Life = 3;
<# This is for later when I have this script create a text doc that pops up with the results

Set-Content C:\DS.txt "Death Saving Throws
Save 1: s1
Save 2: s2
Save 3: s3
Save 4: s4
Save 5: s5
Save 6: s6

SUCCESSES: 
FAILURES: 

RESULT: unkown"
#>

While($failures -ne 3 -and $saves -ne 3){

    $S1
        IF($s1 -gt "1" -and $s1 -lt "10"){
            $save1 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s1 -gt "9" -AND $s1 -lt "20"){
            $save1 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S1 -eq "1"){
            $save1 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S1 -eq "20"){
            $save1 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}

Echo ""
Start-sleep -Seconds 6

While($failures -ne 3 -and $saves -ne 3){

    $S2
        IF($s2 -gt "1" -and $s2 -lt "10"){
            $save2 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s2 -gt "9" -AND $s2 -lt "20"){
            $save2 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S2 -eq "1"){
            $save2 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S2 -eq "20"){
            $save2 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}

Echo ""
Start-sleep -Seconds 6

While($failures -ne 3 -and $saves -ne 3){

    $S3
        IF($s3 -gt "1" -and $s3 -lt "10"){
            $save3 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s3 -gt "9" -AND $s3 -lt "20"){
            $save3 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S3 -eq "1"){
            $save3 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S3 -eq "20"){
            $save3 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}

Echo ""
Start-sleep -Seconds 6

While($failures -ne 3 -and $saves -ne 3){

    $S4
        IF($s4 -gt "1" -and $s4 -lt "10"){
            $save4 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s4 -gt "9" -AND $s4 -lt "20"){
            $save4 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S4 -eq "1"){
            $save4 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S4 -eq "20"){
            $save4 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}

Echo ""
Start-sleep -Seconds 6

While($failures -ne 3 -and $saves -ne 3){

    $S5
        IF($s5 -gt "1" -and $s5 -lt "10"){
            $save5 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s5 -gt "9" -AND $s5 -lt "20"){
            $save5 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S5 -eq "1"){
            $save5 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S5 -eq "20"){
            $save5 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}

Echo ""
Start-sleep -Seconds 6

While($failures -ne 3 -and $saves -ne 3){

    $S6
        IF($s6 -gt "1" -and $s6 -lt "10"){
            $save6 = "Fail"
            $Failures= $failures+1
            Break
     
        }ELSEIF($s6 -gt "9" -AND $s6 -lt "20"){
            $save6 = "Success"
            $Saves= $Saves+1
            Break
      
        }ELSEIF($S6 -eq "1"){
            $save6 = "Critical failure"
            $Failures=$Failures+2
            Break

        }ELSEIF($S6 -eq "20"){
            $save1 = "Critical Success"
            $Saves= $Saves+3
            Break

        }
}
    Echo "Failures= $Failures"
    Echo "Saves= $Saves"
IF($saves -ge 3){
    Echo "Lives!"
    break
}ELSEIF($Failures -ge 3){
    Echo "Death"
    Break
}ELSE{
    Echo "Next Death Saving Throw"
}
