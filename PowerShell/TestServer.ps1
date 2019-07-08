# Run from my laptop
$computers = Get-DbaCmsRegServer server1353 -group active
Test-DbaConnection -SqlInstance $computers | Out-GridView
