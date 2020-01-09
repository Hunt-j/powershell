$computer= Read-host "Computer Name"

$S= New-PSSession -ComputerName $computer -Credential "DOMAIN\USER"

Invoke-command -Session $s {$BIT=Get-BitLockerVolume | select-object -Property VolumeStatus}
Invoke-command -Session $s {IF($BIT -match "FullyDecrypted"){

    Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes128 -SkipHardwareTest -RecoverypasswordProtector
    $BLK = Get-BitLockerVolume -MountPoint "C:"
    Backup-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $BLK.KeyProtector[1].KeyProtectorId
    


    }ELSE{
         Echo "Computer already encrypted"
         }}
