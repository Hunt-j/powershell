<#
    .SYNOPSIS
        Turn on Bitlocker encryption on a remote computer

    .DESCRIPTION
        Creates a remote session with a computer and activates bitlocker encryption. Then uploads the bitlocker code to AD
        
    .FUNCTIONALITY
        
    .NOTES
            AUTHOR: Hunter Jarvis
            EMAIL: hjarvis@plymouth.edu
#>

#Enter identifying informaition, then creates a remote session

$computer= Read-host "Computer to Encrypt"
$domain= Read-host "Domain?"
$username= Read-host "Your username?"
$S= New-PSSession -ComputerName $computer -Credential "$domain\$username"

#Checks to see if volume is encrypted already
Invoke-command -Session $s {$BIT=Get-BitLockerVolume | select-object -Property VolumeStatus}
Invoke-command -Session $s {IF($BIT -match "FullyDecrypted"){

#Enables Bitlocker, standard configuration
    Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes128 -SkipHardwareTest -RecoverypasswordProtector
#Selects newly bitlockered voluem and uploads key to AD
    $BLK = Get-BitLockerVolume -MountPoint "C:"
    Backup-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $BLK.KeyProtector[1].KeyProtectorId
    }ELSE{
         Echo "Computer already encrypted"
    }
}
