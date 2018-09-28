cls
$array =Import-Csv -Path "C:\users\jimwest\Desktop\vmstlist.csv" -Delimiter ","
$array | ForEach-Object {
    $VmName = $_.ServerName
    $ResourceGroup = $_.ResourceGroup
    
    Write-Host "servername is " $VM " and ResourceGroup is " $RG

   }

