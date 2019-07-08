$server = 'server1353'
$p = Get-Process -Computer $server | Out-GridView -Passthru
$p.id | ForEach-Object { TASKKILL /s $server /f /PID $_ }
